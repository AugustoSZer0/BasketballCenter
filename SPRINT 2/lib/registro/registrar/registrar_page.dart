import 'package:BskCenter/servicos/autenticacao_servico.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../biblioteca/teams_info.dart';

class RegistrarPage extends StatefulWidget {
  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  AutenticacaoServico _autenServico = AutenticacaoServico();

  String? _selectedItem;
  List<String> _items = [];
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  _salvarDados(String username, String senha, String email, String time){
    BuildContext context = this.context;
    _autenServico.cadastraUsuario(username: username, email: email, senha: senha, time: time);
    Navigator.pop(context);
  }

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
        _selectedItem = _items.isNotEmpty ? _items[0] : null;
      });
    } catch (e) {
      List<String> nomesTimes = [];

      for (var time in manualTeamsData) {
        nomesTimes.add(time['full_name']);
      }

      setState(() {
        _items = nomesTimes;
        _selectedItem = _items.isNotEmpty ? _items[0] : null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar'),
        backgroundColor: const Color.fromARGB(203, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Registrar',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 44.0),
            Container(
              width: 200.0,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 200.0,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 200.0,
              child: TextField(
                obscureText: true,
                controller: senhaController,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              'Time Preferido',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 203,
              child: DropdownButton<String>(
                value: _selectedItem,
                items: _items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item.length > 30 ? item.substring(0, 30) + "..." : item,
                      overflow: TextOverflow
                          .ellipsis, // Adiciona "..." se o texto estourar
                    ),
                  );
                }).toList(),
                onChanged: (String? selectedItem) {
                  setState(() {
                    _selectedItem = selectedItem;
                  });
                },
              ),
            ),
            SizedBox(height: 34.0),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final email = emailController.text;
                final senha = senhaController.text;
                final time = _selectedItem ?? '';

                _salvarDados(username, senha, email, time);
              },
              child: Text('Registrar'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
