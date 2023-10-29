import 'package:BskCenter/pages_detail/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:BskCenter/registro/login/login_page.dart';
import 'package:BskCenter/biblioteca/teams_info.dart';
import '../menu/menu_page.dart';

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

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  Future<Map<String, dynamic>?> getLoggedInUserTeam() async {
    final bd = await _recuperarBancoDados();
    final result = await bd.query("usuarios", where: "logado = 1");
    if (result.isNotEmpty) {
      final loggedUser = result[0];
      final userTeamName = loggedUser["time"];
      // Agora, encontre as informações do time com base no nome do time
      final teamInfo = manualTeamsData.firstWhere(
        (team) => team["full_name"] == userTeamName,
        orElse: () => {},
      );
      return teamInfo;
    }
    return null;
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: getLoggedInUserTeam(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Erro ao recuperar informações do time: ${snapshot.error}",
              ),
            ),
          );
        } else {
          final teamInfo = snapshot.data;

          final teamId = teamInfo?["id"] as int? ?? 0;
          final teamColor =
              teamColors[teamId] ?? const Color.fromARGB(203, 0, 0, 0);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Basketball Center'),
              centerTitle: true,
              backgroundColor: teamColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => UserDetailPage(),
                    ))
                        .then((data) async {
                      if (data != null) {
                        setState(() {
                          getLoggedInUserTeam();
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            drawer: const Drawer(child: MenuPage()),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: teamInfo != null
                      ? [
                          Card(
                            elevation: 4,
                            // Adicione sombra ao Card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: teamColor,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  color: const Color.fromARGB(203, 0, 0, 0),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    teamInfo["full_name"],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 40.0,
                                    bottom: 40.0,
                                  ),
                                  child: Image.asset(
                                    'assets/nba-logos/$teamId.png',
                                    fit: BoxFit.contain,
                                    height: 130,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                ),
                                Container(
                                  color: const Color.fromARGB(40, 0, 0, 0),
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  child: ListTile(
                                    title: Text(
                                      "Abreviação: ${teamInfo["abbreviation"]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: const Color.fromARGB(40, 0, 0, 0),
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  child: ListTile(
                                    title: Text(
                                      "Cidade: ${teamInfo["city"]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: const Color.fromARGB(40, 0, 0, 0),
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  child: ListTile(
                                    title: Text(
                                      "Conferência: ${teamInfo["conference"]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: const Color.fromARGB(40, 0, 0, 0),
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  child: ListTile(
                                    title: Text(
                                      "Divisão: ${teamInfo["division"]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]
                      : [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30.0),
                            child: Icon(
                              Icons.error_outline,
                              size: 80,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Time favorito ainda não escolhido!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 50),
                              backgroundColor:
                                  const Color.fromARGB(203, 0, 0, 0),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
