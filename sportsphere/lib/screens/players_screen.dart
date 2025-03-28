import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsphere/screens/p_stat.dart';

class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  Map<String, dynamic> teamsData = {};
  Set<String> favoritePlayers = {};
  Map<String, List<String>> leagueTeams = {
    "Premier League": [
      "Manchester United",
      "Newcastle",
      "Bournemouth",
      "Fulham",
      "Wolves",
      "Liverpool"
    ],
    "Bundesliga": ["Bayern München", "Fortuna Düsseldorf", "SC Freiburg"],
    "Ligue 1": ["Lille", "Lyon", "Marseille"],
    "Eredivisie": ["PEC Zwolle", "Ajax", "Excelsior"],
  };

  @override
  void initState() {
    super.initState();
    loadTeams();
    loadFavorites();
  }

  Future<void> loadTeams() async {
    final List<String> leagueFiles = [
      'assets/scripts/premier_league.json',
      'assets/scripts/bundesliga.json',
      'assets/scripts/ligue1.json',
      'assets/scripts/Eredivisie.json',
    ];

    Map<String, dynamic> allTeams = {};

    for (String file in leagueFiles) {
      try {
        final String response = await rootBundle.loadString(file);
        Map<String, dynamic> leagueData = json.decode(response);

        leagueData.forEach((teamName, players) {
          if (allTeams.containsKey(teamName)) {
            allTeams[teamName].addAll(players);
          } else {
            allTeams[teamName] = players;
          }
        });
      } catch (e) {
        print("Error loading $file: $e");
      }
    }

    setState(() {
      teamsData = allTeams;
    });
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritePlayers = prefs.getStringList('favoritePlayers')?.toSet() ?? {};
    });
  }

  Future<void> toggleFavorite(String playerName) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (favoritePlayers.contains(playerName)) {
        favoritePlayers.remove(playerName);
      } else {
        favoritePlayers.add(playerName);
      }
      prefs.setStringList('favoritePlayers', favoritePlayers.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Football Teams")),
      body: teamsData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: leagueTeams.entries.map((leagueEntry) {
                String leagueName = leagueEntry.key;
                List<String> teamsInLeague = leagueEntry.value;

                List<Widget> teamWidgets = teamsInLeague.map((teamName) {
                  if (!teamsData.containsKey(teamName)) return SizedBox();

                  List<dynamic> players = teamsData[teamName];

                  return ExpansionTile(
                    leading: players.isNotEmpty &&
                            players[0]["statistics"].isNotEmpty
                        ? Image.network(
                            players[0]["statistics"][0]["team"]["logo"],
                            width: 40)
                        : Icon(Icons.sports_soccer),
                    title: Text(teamName),
                    children: players.map((playerData) {
                      String playerName = playerData["player"]["name"];

                      return ListTile(
                        leading: Image.network(
                          playerData["player"]["photo"],
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/placeholder.png',
                                width: 50);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CircularProgressIndicator();
                          },
                        ),
                        title: Text(playerName),
                        subtitle: Text(playerData["player"]["position"] ??
                            "Unknown Position"),
                        trailing: IconButton(
                          icon: Icon(
                            favoritePlayers.contains(playerName)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoritePlayers.contains(playerName)
                                ? Colors.red
                                : null,
                          ),
                          onPressed: () => toggleFavorite(playerName),
                        ),
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
                }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        leagueName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...teamWidgets
                  ],
                );
              }).toList(),
            ),
    );
  }
}
