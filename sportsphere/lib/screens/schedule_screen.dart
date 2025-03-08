import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Map<String, dynamic>> fixtures = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchFixtures();
  }

  Future<void> fetchFixtures() async {
    final String apiUrl =
        "https://v3.football.api-sports.io/fixtures?league=39&season=2022";
    final Map<String, String> headers = {
      'x-rapidapi-host': "v3.football.api-sports.io",
      'x-rapidapi-key':
          "a0ae70bf7c6687247992d15ddff92bfb" // Replace with your API key
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> fixtureList = data["response"];

        setState(() {
          fixtures = fixtureList.map((fixture) {
            return {
              "team1": fixture["teams"]["home"]["name"],
              "team1Logo": fixture["teams"]["home"]["logo"],
              "team2": fixture["teams"]["away"]["name"],
              "team2Logo": fixture["teams"]["away"]["logo"],
              "time": fixture["fixture"]["date"],
              "round": fixture["league"]["round"],
              "venue": fixture["fixture"]["venue"]["name"],
              "status": fixture["fixture"]["status"]["long"],
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Premier League Fixtures")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text("Failed to load fixtures. Please try again."))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: fixtures.length,
                    itemBuilder: (context, index) {
                      final fixture = fixtures[index];
                      return FixtureCard(
                        team1: fixture["team1"],
                        team1Logo: fixture["team1Logo"],
                        team2: fixture["team2"],
                        team2Logo: fixture["team2Logo"],
                        time: fixture["time"],
                        round: fixture["round"],
                        venue: fixture["venue"],
                      );
                    },
                  ),
                ),
    );
  }
}

class FixtureCard extends StatelessWidget {
  final String team1, team1Logo, team2, team2Logo, time, round, venue;

  FixtureCard({
    required this.team1,
    required this.team1Logo,
    required this.team2,
    required this.team2Logo,
    required this.time,
    required this.round,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(round,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.network(team1Logo, width: 40, height: 40),
                    Text(team1, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text("VS",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    Image.network(team2Logo, width: 40, height: 40),
                    Text(team2, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text("Venue: $venue", style: TextStyle(color: Colors.grey)),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(time,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
