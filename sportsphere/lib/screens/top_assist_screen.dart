import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sportsphere/screens/player_card.dart';

class TopAssistsScreen extends StatefulWidget {
  const TopAssistsScreen({super.key});

  @override
  State<TopAssistsScreen> createState() => _TopAssistsScreenState();
}

class _TopAssistsScreenState extends State<TopAssistsScreen> {
  final Map<int, String> leagues = {
    39: "Premier League",
    735: "La Liga",
    61: "Ligue 1",
    78: "Bundesliga",
    135: "Serie A",
    88: "Eredivisie"
  };

  Map<int, List<dynamic>> topAssists = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTopAssists();
  }

  Future<void> fetchTopAssists() async {
    for (var entry in leagues.entries) {
      int leagueId = entry.key;
      String leagueName = entry.value;
      final response = await http.get(
        Uri.parse(
            "https://v3.football.api-sports.io/players/topassists?season=2023&league=$leagueId"),
        headers: {
          'x-rapidapi-host': "v3.football.api-sports.io",
          'x-rapidapi-key': "a0ae70bf7c6687247992d15ddff92bfb",
        },
      );
      print('response');
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.body);
        setState(() {
          topAssists[leagueId] = (data["response"] as List)
              .take(10)
              .map((player) => {
                    "name": player["player"]["name"],
                    "photo": player["player"]["photo"],
                    "goals": player["statistics"][0]["goals"]["assists"],
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
      appBar: AppBar(title: Text("Top Assists")),
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
                    if (topAssists.containsKey(leagueId))
                      ...topAssists[leagueId]!
                          .map((player) => PlayerCard(player: player)),
                    Divider(),
                  ],
                );
              },
            ),
    );
  }
}
