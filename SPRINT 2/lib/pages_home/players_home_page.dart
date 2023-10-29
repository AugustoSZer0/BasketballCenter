import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:BskCenter/models/player.dart';
import '../compare_page/players_compare_page.dart';
import '../menu/menu_page.dart';
import 'package:http/http.dart' as http;
import '../biblioteca/players_info.dart';
import '../pages_detail/user_detail_page.dart';

class PlayersHomePage extends StatefulWidget {
  const PlayersHomePage({Key? key}) : super(key: key);

  @override
  _PlayersHomePageState createState() => _PlayersHomePageState();
}

class _PlayersHomePageState extends State<PlayersHomePage> {
  List<Player> players = [];
  List<int> selectedPlayers = [];
  int currentPage = 1;
  bool isLoading = false;
  bool showLoadMoreButton = true;

  TextEditingController searchController = TextEditingController();

  Future<void> searchPlayers(String query) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      players.clear();
      currentPage = 1;
    });

    try {
      var response = await http.get(
          Uri.https('balldontlie.io', 'api/v1/players', {'search': query}));
      var jsonData = jsonDecode(response.body);

      for (var eachPlayer in jsonData['data']) {
        final player = Player(
          id: eachPlayer['id'],
          fullName: eachPlayer['first_name'] + ' ' + eachPlayer['last_name'],
          team: eachPlayer['team']['name'],
        );

        setState(() {
          players.add(player);
        });
      }
    } catch (error) {
      for (var data in manualPlayersData) {
        final player = Player(
          id: data['id'],
          fullName: data['fullName'],
          team: data['team'],
        );
        setState(() {
          players.add(player);
        });
      }

      showLoadMoreButton = false;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    searchPlayers('');
  }

  Future<void> loadMorePlayers() async {
    if (isLoading || searchController.text.isNotEmpty) return;

    setState(() {
      isLoading = true;
    });

    var response = await http.get(Uri.http('balldontlie.io', 'api/v1/players',
        {'page': (currentPage + 1).toString()}));
    var jsonData = jsonDecode(response.body);

    for (var eachPlayer in jsonData['data']) {
      final player = Player(
        id: eachPlayer['id'],
        fullName: eachPlayer['first_name'] + ' ' + eachPlayer['last_name'],
        team: eachPlayer['team']['name'],
      );

      setState(() {
        players.add(player);
      });
    }

    setState(() {
      isLoading = false;
      currentPage++;
    });
  }

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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Pesquisar Jogador',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchPlayers(searchController.text);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    players.length + (searchController.text.isEmpty ? 1 : 0),
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  if (index == players.length &&
                      searchController.text.isEmpty) {
                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ElevatedButton(
                        onPressed: showLoadMoreButton && !isLoading
                            ? loadMorePlayers
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(203, 0, 0, 0),
                        ),
                        child: const Text(
                          'Carregar Mais',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  }
                  final player = players[index];
                  final isSelected = selectedPlayers.contains(player.id);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedPlayers.remove(player.id);
                        } else {
                          if (selectedPlayers.length < 2) {
                            selectedPlayers.add(player.id);
                          }
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color.fromARGB(91, 68, 137, 255)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(player.fullName),
                          subtitle: Text(player.team),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            selectedPlayers.length == 2 ? Colors.green : Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PlayersComparePage(selectedPlayers: selectedPlayers),
            ),
          );
        },
        child: selectedPlayers.length == 2
            ? const Icon(Icons.check)
            : Text('${selectedPlayers.length}'),
      ),
    );
  }
}
