import 'package:flutter/material.dart';
import 'package:sportsphere/screens/standings.dart';

class StandingsScreen extends StatelessWidget {
  final List<Map<String, String>> leagues = [
    {
      "idLeague": "39",
      "strLeague": "Premier League",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/en/f/f2/Premier_League_Logo.svg"
    },
    {
      "idLeague": "140",
      "strLeague": "La Liga",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/en/1/13/LaLiga.svg"
    },
    {
      "idLeague": "78",
      "strLeague": "Bundesliga",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/en/d/df/Bundesliga_logo_%282017%29.svg"
    },
    {
      "idLeague": "135",
      "strLeague": "Serie A",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/en/e/e1/Serie_A_logo_%282019%29.svg"
    },
    {
      "idLeague": "61",
      "strLeague": "Ligue 1",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/en/2/29/Ligue1.svg"
    },
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
              leading: Image.network(
                leagues[index]['imageUrl']!,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported, size: 50);
                },
              ),
              title: Text(
                leagues[index]['strLeague']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
