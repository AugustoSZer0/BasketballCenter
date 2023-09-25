import 'package:BskCenter/registro/login/login_page.dart';
import 'package:flutter/material.dart';
import '../menu/menu_page.dart';


class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basketball Center'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(203, 0, 0, 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(child: MenuPage()),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Icon(
                  Icons.error_outline,
                  size: 80, // Tamanho do ícone
                  color: Colors.red, // Cor do ícone
                ),
              ),

              const SizedBox(height: 10), // Espaço entre o ícone e o texto
              const Text(
                'Time favorito ainda não escolhido!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: const Color.fromARGB(203, 0, 0, 0),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
