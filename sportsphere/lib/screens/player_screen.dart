import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sportsphere/screens/player_card.dart';
import 'package:sportsphere/screens/top_assist_screen.dart';
import 'package:sportsphere/screens/top_scorer._screen.dart';

class PlayersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
        automaticallyImplyLeading: false,
      ),
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
