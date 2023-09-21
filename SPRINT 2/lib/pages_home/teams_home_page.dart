import 'dart:convert';
import 'package:flutter/material.dart';
import '../pages_detail/team_detail_page.dart';
import '../menu/menu_page.dart';
import 'package:http/http.dart' as http;
import '../models/team.dart';
import '../biblioteca/teams_info.dart';

// ignore: must_be_immutable
class TeamsHomePage extends StatefulWidget {
  TeamsHomePage({Key? key}) : super(key: key);

  @override
  _TeamsHomePageState createState() => _TeamsHomePageState();
}

class _TeamsHomePageState extends State<TeamsHomePage> {
  List<Team> teams = [];

  @override
  void initState() {
    super.initState();
  }

  // get teams
  Future<void> getTeams() async {
    try {
      // Primeiro, tenta fazer a solicitação para balldontlie.io
      final ballDonLieUrl = Uri.parse('https://balldontlie.io/api/v1/teams');
      final ballDonLieResponse = await http.get(ballDonLieUrl);

      final jsonData = jsonDecode(ballDonLieResponse.body);

      for (var eachTeam in jsonData['data']) {
        final team = Team(
          id: eachTeam['id'],
          fullName: eachTeam['full_name'],
          abbreviation: eachTeam['abbreviation'],
          city: eachTeam['city'],
          division: eachTeam['division'],
          conference: eachTeam['conference'],
        );
        teams.add(team);
      }
    } catch (error) {
      for (var data in manualTeamsData) {
        final team = Team(
          id: data['id'],
          fullName: data['full_name'],
          abbreviation: data['abbreviation'],
          city: data['city'],
          division: data['division'],
          conference: data['conference'],
        );
        teams.add(team);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basketball Center'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(203, 0, 0, 0),
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
          future: getTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: teams.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeamDetailPage(
                            team: teams[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(teams[index].abbreviation),
                          subtitle: Text(teams[index].fullName),
                          leading: Image(
                              image: AssetImage(
                                  'assets/nba-logos/${teams[index].id}.png')),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
