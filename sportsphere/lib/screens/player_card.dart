import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerCard extends StatefulWidget {
  final Map<String, dynamic> player;

  const PlayerCard({super.key, required this.player});

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePlayers = prefs.getStringList('favoritePlayers') ?? [];
    setState(() {
      isFavorite = favoritePlayers.contains(widget.player['name']);
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePlayers = prefs.getStringList('favoritePlayers') ?? [];
    print(favoritePlayers);

    if (isFavorite) {
      favoritePlayers.remove(widget.player['name']);
    } else {
      favoritePlayers.add(widget.player['name']);
    }

    await prefs.setStringList('favoritePlayers', favoritePlayers);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.network(widget.player['photo'], width: 40, height: 40),
        title: Text(
          widget.player['name'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Assists: ${widget.player['goals']}"),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: _toggleFavorite,
        ),
      ),
    );
  }
}
