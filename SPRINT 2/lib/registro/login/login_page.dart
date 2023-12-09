import 'package:BskCenter/pages_home/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:BskCenter/registro/registrar/registrar_page.dart';

import '../../pages_home/user_home_page.dart';
import '../../servicos/autenticacao_servico.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AutenticacaoServico _autenServico = AutenticacaoServico();
  
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future<void> fazerLogin() async {
    BuildContext context = this.context;
    var resultado = await _autenServico.login(emailController.text, senhaController.text);
    
    if(resultado != false){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login realizado!"),
        backgroundColor: Colors.green,
      ));

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return UserHomePage();
        },
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("E-mail ou senha incorretos."),
        backgroundColor: Colors.red,
      ));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              'Login',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            Container(
              width: 280.0,
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
              width: 280.0,
              child: TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                await fazerLogin();
              },
              child: Text('Entrar'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                backgroundColor: const Color.fromARGB(203, 0, 0, 0),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegistrarPage(),
                  ),
                );
              },
              child: Text('Registrar'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                backgroundColor: const Color.fromARGB(203, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Principal'),
      ),
      body: Center(
        child: Text('Bem-vindo à Tela Principal!'),
      ),
    );
  }
}
