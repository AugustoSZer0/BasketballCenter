import 'dart:convert';

import 'package:BskCenter/servicos/autenticacao_servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../biblioteca/teams_info.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  AutenticacaoServico _autenServico = AutenticacaoServico();


  String? _selectedItem;
  List<String> _items = [];

  _carregarTimes() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.balldontlie.io/api/v1/teams'));

      final data = json.decode(response.body);
      final times = data['data'];

      List<String> nomesTimes = [];

      for (var time in times) {
        nomesTimes.add(time['full_name']);
      }

      setState(() {
        _items = nomesTimes;
      });
    } catch (e) {
      List<String> nomesTimes = [];

      for (var time in manualTeamsData) {
        nomesTimes.add(time['full_name']);
      }

      setState(() {
        _items = nomesTimes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
    _carregarTimes();
  }

  _carregarDadosUsuario() async {
    User? usuario = await _autenServico.recuperaUsuarioLogado();
    
    if (usuario != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await _firebaseFirestore.collection('time').doc(usuario.uid).get();
      
      setState(() {
        usernameController.text = '${usuario.displayName}';
        emailController.text = '${usuario.email}';
        _selectedItem = userSnapshot.data()?['nomeTime'];
      });
    }
  }

  _atualizarUsuario() async {
    try {
      User? usuario = await _autenServico.recuperaUsuarioLogado();

      if (usuario != null) {
        DocumentReference<Map<String, dynamic>> usuarioRef = FirebaseFirestore.instance.collection('time').doc(usuario.uid);
        DocumentSnapshot<Map<String, dynamic>> usuarioSnapshot = await usuarioRef.get();
        Map<String, dynamic>? dadosAtuais = usuarioSnapshot.data();
        
        await usuario.verifyBeforeUpdateEmail(emailController.text);
        if(senhaController.text != null){
          await usuario.updatePassword(senhaController.text);
        }
        await usuario.updateDisplayName(usernameController.text);

        if (dadosAtuais != null) {
          dadosAtuais['nomeTime'] = _selectedItem; 
          await usuarioRef.update(dadosAtuais);
        }

        await usuario.reload();
        usuario = FirebaseAuth.instance.currentUser;

        _mostrarSnackBar("Alterações salvas com sucesso!");
      } else {
        print('Nenhum usuário logado.');
      }
    } catch (e) {
      print('Erro ao atualizar perfil do usuário: $e');
    }
  }

  _sairDaConta() async {
    BuildContext context = this.context;
    await FirebaseAuth.instance.signOut();
    _mostrarSnackBar("Conta desconectada!");
    Navigator.of(context).pop({
      'time': _selectedItem,
    });
  }

  _excluirConta() async {
    BuildContext context = this.context;
    User? usuario = await _autenServico.recuperaUsuarioLogado();

    if (usuario != null) {
      await FirebaseFirestore.instance.collection('time').doc(usuario.uid).delete();
      await usuario.delete();
      _mostrarSnackBar("Conta excluida com sucesso!");
      Navigator.of(context).pop({
        'time': _selectedItem,
      });
    }
  }

  _mostrarSnackBar(String mensagem) {
    BuildContext context = this.context;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar'),
          backgroundColor: const Color.fromARGB(203, 0, 0, 0),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop({
                'time': _selectedItem,
              });
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Editar Usuário',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60.0),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Nome de usuário'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  controller: senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Time Preferido',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                  items: _items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () {
                    _atualizarUsuario();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: const Color.fromARGB(203, 0, 0, 0),
                  ),
                  child: const Text('Salvar Alterações',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: _sairDaConta,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: const Color.fromARGB(203, 0, 0, 0),
                  ),
                  child: const Text('Sair da Conta',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    _excluirConta();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Excluir Conta',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ));
  }
}
