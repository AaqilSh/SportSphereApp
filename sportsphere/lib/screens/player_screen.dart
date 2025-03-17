import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sportsphere/screens/player_card.dart';
import 'package:sportsphere/screens/top_assist_screen.dart';
import 'package:sportsphere/screens/top_scorer._screen.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildPlayerCategoryCard(
              context,
              title: "Top Scorers",
              subtitle: "See the highest goal scorers",
              icon: Icons.sports_soccer,
              screen: TopScorersScreen(),
            ),
            SizedBox(height: 16),
            _buildPlayerCategoryCard(
              context,
              title: "Top Assists",
              subtitle: "See players with the most assists",
              icon: Icons.assist_walker,
              screen: TopAssistsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerCategoryCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required Widget screen}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blueAccent),
        title: Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle:
            Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}
