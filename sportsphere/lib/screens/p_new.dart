import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportsphere/screens/p_stat.dart';

class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  Map<String, dynamic> teams = {};
  Map<String, dynamic> teamsData = {};

  @override
  void initState() {
    super.initState();
    loadTeams();
  }

  Future<void> loadTeams() async {
    final String response =
        await rootBundle.loadString('assets/scripts/league_players.json');
    setState(() {
      teamsData = json.decode(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Football Teams")),
      body: teamsData.isEmpty
          ? Center(
              child: CircularProgressIndicator()) // Show loader while loading
          : ListView(
              children: teamsData.entries.map((entry) {
                String teamName = entry.key;
                List<dynamic> players = entry.value;

                return ExpansionTile(
                  leading:
                      players.isNotEmpty && players[0]["statistics"].isNotEmpty
                          ? Image.network(
                              players[0]["statistics"][0]["team"]["logo"],
                              width: 40)
                          : Icon(Icons.sports_soccer),
                  title: Text(teamName),
                  children: players.map((playerData) {
                    return ListTile(
                      leading: Image.network(playerData["player"]["photo"],
                          width: 50),
                      title: Text(playerData["player"]["name"]),
                      subtitle: Text(playerData["player"]["position"] ??
                          "Unknown Position"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlayerStatsScreen(playerData: playerData),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }).toList(),
            ),
    );
  }
}
