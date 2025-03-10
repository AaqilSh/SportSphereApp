import 'package:flutter/material.dart';

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
