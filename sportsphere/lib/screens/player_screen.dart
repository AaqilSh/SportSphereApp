import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlayersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Players")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TopScorersScreen()));
              },
              child: Text("Top Scorers"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TopAssistsScreen()));
              },
              child: Text("Top Assists"),
            ),
          ],
        ),
      ),
    );
  }
}

class TopScorersScreen extends StatefulWidget {
  @override
  _TopScorersScreenState createState() => _TopScorersScreenState();
}

class _TopScorersScreenState extends State<TopScorersScreen> {
  final List<int> leagueIds = [39, 140, 61, 78, 135, 88]; // Example leagues
  Map<int, List<Map<String, dynamic>>> topScorers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTopScorers();
  }

  Future<void> fetchTopScorers() async {
    for (int leagueId in leagueIds) {
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
          : ListView(
              children: leagueIds.map((leagueId) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("League $leagueId",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    ...topScorers[leagueId]
                            ?.map((player) => PlayerCard(player: player)) ??
                        [],
                  ],
                );
              }).toList(),
            ),
    );
  }
}

class TopAssistsScreen extends StatefulWidget {
  @override
  State<TopAssistsScreen> createState() => _TopAssistsScreenState();
}

class _TopAssistsScreenState extends State<TopAssistsScreen> {
  final List<int> leagueIds = [39, 140, 61, 78, 135, 88];
  Map<int, List<Map<String, dynamic>>> topAssists = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTopAssists();
  }

  Future<void> fetchTopAssists() async {
    for (int leagueId in leagueIds) {
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
          : ListView(
              children: leagueIds.map((leagueId) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("League $leagueId",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    ...topAssists[leagueId]
                            ?.map((player) => PlayerCard(player: player)) ??
                        [],
                  ],
                );
              }).toList(),
            ),
    );
  }
}

class PlayerCard extends StatelessWidget {
  final Map<String, dynamic> player;

  PlayerCard({required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(player["photo"], width: 50, height: 50),
        title: Text(player["name"]),
        subtitle: Text("Goals: ${player["goals"]}"),
      ),
    );
  }
}
