import 'package:flutter/material.dart';
import 'package:BskCenter/registro/registrar/registrar_page.dart';


class LoginPage extends StatelessWidget {
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
              onPressed: () {},
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