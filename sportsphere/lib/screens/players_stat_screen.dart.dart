import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerStatsScreen extends StatefulWidget {
  final Map<String, dynamic> playerData;

  const PlayerStatsScreen({Key? key, required this.playerData})
      : super(key: key);

  @override
  _PlayerStatsScreenState createState() => _PlayerStatsScreenState();
}

class _PlayerStatsScreenState extends State<PlayerStatsScreen> {
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

  Future<void> toggleFavorite(String playerName) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (favoritePlayers.contains(playerName)) {
        favoritePlayers.remove(playerName);
      } else {
        favoritePlayers.add(playerName);
      }
      prefs.setStringList('favoritePlayers', favoritePlayers.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    var player = widget.playerData["player"];
    var stats = widget.playerData["statistics"][0]["games"];
    String playerName = player["name"];

    return Scaffold(
      appBar: AppBar(
        title: Text(playerName),
        actions: [
          IconButton(
            icon: Icon(
              favoritePlayers.contains(playerName)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: favoritePlayers.contains(playerName) ? Colors.red : null,
            ),
            onPressed: () => toggleFavorite(playerName),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(player["photo"]),
            ),
            SizedBox(height: 10),
            Text(playerName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(player["nationality"],
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 10),
            Divider(),
            _buildStatRow("Position", stats["position"]),
            _buildStatRow("Appearances", stats["appearences"]),
            _buildStatRow("Minutes Played", stats["minutes"]),
            _buildStatRow(
                "Goals", widget.playerData["statistics"][0]["goals"]["total"]),
            _buildStatRow("Assists",
                widget.playerData["statistics"][0]["goals"]["assists"]),
            _buildStatRow("Yellow Cards",
                widget.playerData["statistics"][0]["cards"]["yellow"]),
            _buildStatRow("Red Cards",
                widget.playerData["statistics"][0]["cards"]["red"]),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Text(value != null ? value.toString() : "N/A",
              style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
