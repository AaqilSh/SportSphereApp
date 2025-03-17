import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteTeamsScreen extends StatefulWidget {
  const FavoriteTeamsScreen({super.key});

  @override
  _FavoriteTeamsScreenState createState() => _FavoriteTeamsScreenState();
}

class _FavoriteTeamsScreenState extends State<FavoriteTeamsScreen> {
  List<Map<String, dynamic>> favoriteTeams = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteTeams();
  }

  Future<void> loadFavoriteTeams() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoriteTeamsString = prefs.getString('favorite_teams');
    if (favoriteTeamsString != null) {
      setState(() {
        favoriteTeams =
            List<Map<String, dynamic>>.from(json.decode(favoriteTeamsString));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Teams")),
      body: favoriteTeams.isEmpty
          ? Center(child: Text("No favorite teams yet."))
          : ListView.builder(
              itemCount: favoriteTeams.length,
              itemBuilder: (context, index) {
                final team = favoriteTeams[index];
                return ListTile(
                  leading: Image.network(team["logo"], width: 40, height: 40),
                  title: Text(team["name"]),
                );
              },
            ),
    );
  }
}
