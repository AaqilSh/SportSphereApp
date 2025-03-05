import 'package:flutter/material.dart';

class TeamsScreen extends StatelessWidget {
  final List<Map<String, String>> teams = [
    {
      "name": "Manchester United",
      "country": "England",
      "logo": "assets/manutd.png",
    },
    {
      "name": "Manchester City",
      "country": "England",
      "logo": "assets/mancity.png",
    },
    {
      "name": "Liverpool",
      "country": "England",
      "logo": "assets/liverpool.png",
    },
    {
      "name": "Arsenal",
      "country": "England",
      "logo": "assets/arsenal.png",
    },
    {
      "name": "Real Madrid",
      "country": "Spain",
      "logo": "assets/realmadrid.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teams")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("TEAMS",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return TeamCard(
                    name: team["name"]!,
                    country: team["country"]!,
                    logo: team["logo"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final String name, country, logo;

  TeamCard({required this.name, required this.country, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset(logo, width: 40, height: 40),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(country, style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
