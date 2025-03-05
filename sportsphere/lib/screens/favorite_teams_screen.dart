import 'package:flutter/material.dart';

class FavoriteTeamsScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteTeams = [
    {"name": "Manchester United", "country": "England"},
    {"name": "Real Madrid", "country": "Spain"},
    {"name": "Barcelona", "country": "Spain"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Teams"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: favoriteTeams.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.sports_soccer, color: Colors.black),
              title: Text(
                favoriteTeams[index]["name"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(favoriteTeams[index]["country"]!),
            ),
          );
        },
      ),
    );
  }
}
