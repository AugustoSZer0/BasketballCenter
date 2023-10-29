import 'package:BskCenter/pages_home/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:BskCenter/registro/registrar/registrar_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future<Database> _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco8.bd");
    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, username VARCHAR, email VARCHAR, senha VARCHAR, logado INTEGER)";
      db.execute(sql);
    });
    return bd;
  }

  Future<void> fazerLogin() async {
    BuildContext context = this.context;
    final String email = emailController.text;
    final String senha = senhaController.text;

    Database bd = await _recuperarBancoDados();

    List<Map<String, dynamic>> resultados = await bd.query(
      "usuarios",
      where: "email = ? AND senha = ?",
      whereArgs: [email, senha],
    );

    if (resultados.isNotEmpty) {
      await bd.update(
        "usuarios",
        {"logado": 1},
        where: "email = ?",
        whereArgs: [email],
      );

      // Redirecione para a próxima tela ou realize a ação desejada
      // Por exemplo, navegar para a página principal
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login realizado!"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return UserHomePage();
        },
      ));
    } else {
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
