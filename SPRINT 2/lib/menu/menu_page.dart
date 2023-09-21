import 'package:flutter/material.dart';
import 'package:BskCenter/pages_home/players_home_page.dart';
import 'package:BskCenter/pages_home/user_home_page.dart';
import '../pages_home/teams_home_page.dart';
import '../sobre/sobre_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(203, 0, 0, 0),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Basketball Center',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
              iconColor: Colors.black,
              leading: const Icon(
                Icons.home,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  fontSize: 20, // Defina o tamanho da fonte, se desejar.
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHomePage(),
                  ),
                );
              },
              contentPadding: const EdgeInsets.all(16)),
          ListTile(
              iconColor: Colors.black,
              leading: const Icon(
                Icons.sports_basketball,
              ),
              title: const Text(
                'Todos os Times',
                style: TextStyle(
                  fontSize: 20, // Defina o tamanho da fonte, se desejar.
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamsHomePage(),
                  ),
                );
              },
              contentPadding: const EdgeInsets.all(16)),
          ListTile(
            iconColor: Colors.black,
            leading: const Icon(
              Icons.bar_chart,
            ),
            title: const Text(
              'Head 2 Head',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayersHomePage(),
                ),
              );
            },
            contentPadding: const EdgeInsets.all(16),
          ),
          ListTile(
            iconColor: Colors.black,
            leading: const Icon(
              Icons.info,
            ),
            title: const Text(
              'Sobre',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SobrePage(),
                ),
              );
            },
            contentPadding: const EdgeInsets.all(16),
          )
        ],
      ),
    );
  }
}
