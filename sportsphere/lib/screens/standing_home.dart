import 'package:flutter/material.dart';
import 'package:sportsphere/screens/standings.dart';

class StandingsScreen extends StatelessWidget {
  final List<Map<String, String>> leagues = [
    {"idLeague": "39", "strLeague": "Premier League"},
    {"idLeague": "4331", "strLeague": "La Liga"},
    {"idLeague": "4335", "strLeague": "Bundesliga"},
    {"idLeague": "4334", "strLeague": "Serie A"},
    {"idLeague": "4332", "strLeague": "Ligue 1"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standings')),
      body: ListView.builder(
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xffDAF0F2),
            child: ListTile(
              title: Text(leagues[index]['strLeague']!),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeagueStandingsScreen(
                      leagueId: leagues[index]['idLeague']!,
                      leagueName: leagues[index]['strLeague']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
