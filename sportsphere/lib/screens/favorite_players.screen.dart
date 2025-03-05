import 'package:flutter/material.dart';

class FavoritePlayersScreen extends StatelessWidget {
  final List<Map<String, String>> favoritePlayers = [
    {"name": "Cristiano Ronaldo", "team": "Al Nassr"},
    {"name": "Lionel Messi", "team": "Inter Miami"},
    {"name": "Neymar Jr", "team": "Al Hilal"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Players"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: favoritePlayers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text(
                favoritePlayers[index]["name"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(favoritePlayers[index]["team"]!),
            ),
          );
        },
      ),
    );
  }
}
