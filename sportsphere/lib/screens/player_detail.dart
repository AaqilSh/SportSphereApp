import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsphere/models/player.dart';

class PlayerDetailsScreen extends StatefulWidget {
  final Player player;

  const PlayerDetailsScreen({super.key, required this.player});

  @override
  _PlayerDetailsScreenState createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  Set<String> favoritePlayers = {};

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritePlayers = prefs.getStringList('favoritePlayers')?.toSet() ?? {};
    });
  }

  Future<void> toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoritePlayers.contains(widget.player.strPlayer)) {
        favoritePlayers.remove(widget.player.strPlayer);
      } else {
        favoritePlayers.add(widget.player.strPlayer);
      }
      prefs.setStringList('favoritePlayers', favoritePlayers.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    String teamName = widget.player.strTeam == "_Retired Soccer"
        ? "Retired Player"
        : widget.player.strTeam;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.strPlayer),
        actions: [
          IconButton(
            icon: Icon(
              favoritePlayers.contains(widget.player.strPlayer)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: favoritePlayers.contains(widget.player.strPlayer)
                  ? Colors.red
                  : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.player.strCutout.isNotEmpty)
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.player.strCutout),
                ),
              SizedBox(height: 16),
              Text(
                widget.player.strPlayer,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                teamName,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 8),
              Text(
                '${widget.player.strPosition} - ${widget.player.strNationality}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Born: ${widget.player.dateBorn}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
