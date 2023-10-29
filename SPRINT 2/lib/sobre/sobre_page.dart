import 'package:flutter/material.dart';

import '../menu/menu_page.dart';
import '../pages_detail/user_detail_page.dart';

class SobrePage extends StatelessWidget {
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserDetailPage(),
              ));
            },
          ),
        ],
      ),
      drawer: const Drawer(child: MenuPage()),
      body: const Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sobre nós',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(bottom: 22.0),
              child: Text(
                'Somos um grupo de estudantes da PUC Minas, atualmente no quarto período do Curso de Ciência da Computação.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(
              // Adicionando uma linha divisória
              color: Colors.black,
            ),
            SizedBox(height: 16),
            Text(
              'Missão',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(bottom: 22.0),
              child: Text(
                'Nossa missão é fornecer um app ágil e com funcionalidades divertidas para o fã de basquete.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 16),
            Text(
              'Basketball Center',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Nosso app visa proporcionar aos usuários uma experiência completa ao fornecer informações detalhadas sobre times da NBA e permitir a comparação de jogadores da liga.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
