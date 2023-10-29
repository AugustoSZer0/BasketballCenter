import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../biblioteca/teams_info.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

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
    final bd = await _recuperarBancoDados();
    final result =
        await bd.query("usuarios", where: "logado = ?", whereArgs: [1]);
    if (result.isNotEmpty) {
      final user = result.first;
      setState(() {
        usernameController.text = user["username"];
        emailController.text = user["email"];
        senhaController.text = user["senha"];
        _selectedItem = user["time"];
      });
    }
  }

  _atualizarUsuario() async {
    final bd = await _recuperarBancoDados();
    final updatedUser = {
      "username": usernameController.text,
      "email": emailController.text,
      "senha": senhaController.text,
      "time": _selectedItem,
    };
    await bd
        .update("usuarios", updatedUser, where: "logado = ?", whereArgs: [1]);
    _mostrarSnackBar("Alterações salvas com sucesso!");
  }

  _sairDaConta() async {
    BuildContext context = this.context;
    final bd = await _recuperarBancoDados();
    await bd.update("usuarios", {"logado": 0},
        where: "logado = ?", whereArgs: [1]);
    _mostrarSnackBar("Conta desconectada!");
    Navigator.of(context).pop({
      'time': _selectedItem,
    });
  }

  _excluirConta() async {
    BuildContext context = this.context;
    final bd = await _recuperarBancoDados();
    await bd.delete("usuarios", where: "logado = ?", whereArgs: [1]);
    _mostrarSnackBar("Conta excluída!");
    Navigator.of(context).pop({
      'time': _selectedItem,
    });
  }

  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco8.bd");
    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, username VARCHAR, email VARCHAR, senha VARCHAR, logado INTEGER, time VARCHAR)";
      db.execute(sql);
    });
    return bd;
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
