import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePlayersScreen extends StatefulWidget {
  const FavoritePlayersScreen({super.key});

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

  Future<void> _removeFromFavorites(String player) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritePlayers.remove(player);
    });
    await prefs.setStringList('favoritePlayers', favoritePlayers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Players")),
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
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          _removeFromFavorites(favoritePlayers[index]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
