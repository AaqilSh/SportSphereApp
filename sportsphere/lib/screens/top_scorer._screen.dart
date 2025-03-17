import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sportsphere/screens/player_card.dart';

class TopScorersScreen extends StatefulWidget {
  const TopScorersScreen({super.key});

  @override
  _TopScorersScreenState createState() => _TopScorersScreenState();
}

class _TopScorersScreenState extends State<TopScorersScreen> {
  final Map<int, String> leagues = {
    39: "Premier League",
    735: "La Liga",
    61: "Ligue 1",
    78: "Bundesliga",
    135: "Serie A",
    88: "Eredivisie"
  };

  Map<int, List<dynamic>> topScorers = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTopScorers();
  }

  Future<void> fetchTopScorers() async {
    for (var entry in leagues.entries) {
      int leagueId = entry.key;
      String leagueName = entry.value;
      final response = await http.get(
        Uri.parse(
            "https://v3.football.api-sports.io/players/topscorers?season=2023&league=$leagueId"),
        headers: {
          'x-rapidapi-host': "v3.football.api-sports.io",
          'x-rapidapi-key': "a0ae70bf7c6687247992d15ddff92bfb",
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.body);
        setState(() {
          topScorers[leagueId] = (data["response"] as List)
              .take(10)
              .map((player) => {
                    "name": player["player"]["name"],
                    "photo": player["player"]["photo"],
                    "goals": player["statistics"][0]["goals"]["total"],
                  })
              .toList();
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Top Scorers")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                int leagueId = leagues.keys.elementAt(index);
                String leagueName = leagues.values.elementAt(index);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(leagueName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    if (topScorers.containsKey(leagueId))
                      ...topScorers[leagueId]!
                          .map((player) => PlayerCard(player: player))
                          ,
                    Divider(),
                  ],
                );
              },
            ),
    );
  }
}
