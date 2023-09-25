import 'package:flutter/material.dart';
import 'package:BskCenter/models/player.dart';
import 'package:BskCenter/pages_detail/player_detail_page.dart';
import 'dart:convert';
import '../menu/menu_page.dart';
import 'package:http/http.dart' as http;
import '../models/playerWithStats.dart';
import '../biblioteca/players_info.dart';

class PlayersComparePage extends StatelessWidget {
  List<int> selectedPlayers;
  List<PlayerWithStats> players = [];

  PlayersComparePage({required this.selectedPlayers});

  Future getPlayersInfo() async {
    for (var i = 0; i < 2; i++) {
      try {
        var responsePlayers = await http.get(Uri.https(
            'balldontlie.io', 'api/v1/players/${selectedPlayers[i]}'));
        var jsonDataPlayers = jsonDecode(responsePlayers.body);

        final responseStats = await http.get(
          Uri.https(
            'www.balldontlie.io',
            'api/v1/season_averages',
            {
              'season': '2018',
              'player_ids[]': selectedPlayers[i].toString(),
            },
          ),
        );

        var jsonDataStats = jsonDecode(responseStats.body);

        if (jsonDataStats['data'] != null && jsonDataStats['data'].isNotEmpty) {
          final playerStats = jsonDataStats['data'][0];

          final playerResponse = PlayerWithStats(
            fullName: jsonDataPlayers['first_name'] +
                ' ' +
                jsonDataPlayers['last_name'],
            team: jsonDataPlayers['team']['name'],
            gamesPlayed: playerStats['games_played'],
            points: playerStats['pts'],
            assists: playerStats['ast'],
            rebounds: playerStats['reb'],
          );

          players.add(playerResponse);
        }
      } catch (erro) {
        for (var data in manualPlayersData) {
          if (selectedPlayers[i] == data['id']) {
            final playerResponse = PlayerWithStats(
              fullName: data['fullName'],
              team: data['team'],
              gamesPlayed: data['gamesPlayed'],
              points: data['points'],
              assists: data['assists'],
              rebounds: data['rebounds'],
            );

            players.add(playerResponse);
          }
        }
      }
    }
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
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(child: (MenuPage())),
      body: SafeArea(
        child: FutureBuilder(
          future: getPlayersInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: players.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return PlayerDetailPage(player: players[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
