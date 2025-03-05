import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  final List<Map<String, String>> fixtures = [
    {
      "team1": "Chelsea",
      "team1Logo": "assets/chelsea.png",
      "team2": "Man Utd",
      "team2Logo": "assets/manutd.png",
      "time": "7pm",
      "round": "PLAYOFFS - ROUND 1",
    },
    {
      "team1": "Albion",
      "team1Logo": "assets/albion.png",
      "team2": "Arsenal",
      "team2Logo": "assets/arsenal.png",
      "time": "7pm",
      "round": "PLAYOFFS - ROUND 2",
    },
    {
      "team1": "Man City",
      "team1Logo": "assets/mancity.png",
      "team2": "Liverpool",
      "team2Logo": "assets/liverpool.png",
      "time": "7pm",
      "round": "PLAYOFFS - ROUND 3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fixtures")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: fixtures.length,
          itemBuilder: (context, index) {
            final fixture = fixtures[index];
            return FixtureCard(
              team1: fixture["team1"]!,
              team1Logo: fixture["team1Logo"]!,
              team2: fixture["team2"]!,
              team2Logo: fixture["team2Logo"]!,
              time: fixture["time"]!,
              round: fixture["round"]!,
            );
          },
        ),
      ),
    );
  }
}

class FixtureCard extends StatelessWidget {
  final String team1, team1Logo, team2, team2Logo, time, round;

  FixtureCard({
    required this.team1,
    required this.team1Logo,
    required this.team2,
    required this.team2Logo,
    required this.time,
    required this.round,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(team1Logo, width: 40, height: 40),
                Text("VS",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Image.asset(team2Logo, width: 40, height: 40),
              ],
            ),
            SizedBox(height: 8),
            Text("$team1  vs  $team2",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text("$round", style: TextStyle(color: Colors.grey)),
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
