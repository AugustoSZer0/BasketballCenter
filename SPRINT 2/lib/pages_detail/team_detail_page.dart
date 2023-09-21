import 'package:flutter/material.dart';
import '../models/team.dart';

class TeamDetailPage extends StatelessWidget {
  final Team team;

  // Mapa de cores personalizadas para cada equipe (em ordem alfabética por nome da equipe)
  final Map<int, Color> teamColors = {
    1: Colors.red, // Atlanta Hawks
    2: Colors.green, // Boston Celtics
    3: Colors.black, // Brooklyn Nets
    4: Colors.teal, // Charlotte Hornets
    5: Colors.redAccent, // Chicago Bulls
    6: Colors.red, // Cleveland Cavaliers
    7: Colors.blueAccent, // Dallas Mavericks
    8: Colors.blueAccent, // Denver Nuggets
    9: Colors.redAccent, // Detroit Pistons
    10: Colors.orange, // Golden State Warriors
    11: Colors.red, // Houston Rockets
    12: Colors.blueGrey, // Indiana Pacers
    13: Colors.blue, // LA Clippers
    14: Colors.purple, // Los Angeles Lakers
    15: Colors.blue, // Memphis Grizzlies
    16: Colors.red, // Miami Heat
    17: const Color.fromARGB(255, 38, 117, 41), // Milwaukee Bucks
    18: Colors.blue, // Minnesota Timberwolves
    19: Colors.teal, // New Orleans Pelicans
    20: Colors.blue, // New York Knicks
    21: Colors.red, // Oklahoma City Thunder
    22: Colors.grey, // Orlando Magic
    23: Colors.red, // Philadelphia 76ers
    24: Colors.purple, // Phoenix Suns
    25: Colors.black, // Portland Trail Blazers
    26: Colors.purple, // Sacramento Kings
    27: Colors.grey, // San Antonio Spurs
    28: Colors.red, // Toronto Raptors
    29: Colors.green, // Utah Jazz
    30: Colors.red, // Washington Wizards
  };

  TeamDetailPage({required this.team});

  @override
  Widget build(BuildContext context) {
    // Obtém a cor correspondente ao ID da equipe
    Color appBarColor = teamColors[team.id] ?? Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          team.fullName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/nba-logos/${team.id}.png',
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              const Text(
                'Informações',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  'Abreviação:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  team.abbreviation,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              ListTile(
                title: Text(
                  'Cidade:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  team.city,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              ListTile(
                title: Text(
                  'Conferência:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  team.conference,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              ListTile(
                title: Text(
                  'Divisão:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  team.division,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
