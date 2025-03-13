import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePlayersScreen extends StatefulWidget {
  @override
  _FavoritePlayersScreenState createState() => _FavoritePlayersScreenState();
}

class _FavoritePlayersScreenState extends State<FavoritePlayersScreen> {
  List<String> favoritePlayers = [];

  @override
  void initState() {
    super.initState();
    _loadFavoritePlayers();
  }

  Future<void> _loadFavoritePlayers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritePlayers = prefs.getStringList('favoritePlayers') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Favorite Players"), backgroundColor: Colors.black),
      body: favoritePlayers.isEmpty
          ? Center(child: Text("No favorite players added"))
          : ListView.builder(
              itemCount: favoritePlayers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.black),
                    title: Text(
                      favoritePlayers[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
