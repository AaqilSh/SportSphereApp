import 'package:flutter/material.dart';

class PlayerStatsScreen extends StatelessWidget {
  final Map<String, dynamic> playerData;

  const PlayerStatsScreen({Key? key, required this.playerData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var player = playerData["player"];
    var stats = playerData["statistics"][0]["games"];

    return Scaffold(
      appBar: AppBar(title: Text(player["name"])),
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
            Text(player["name"],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(player["nationality"],
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 10),
            Divider(),
            _buildStatRow("Position", stats["position"]),
            _buildStatRow("Appearances", stats["appearences"]),
            _buildStatRow("Minutes Played", stats["minutes"]),
            _buildStatRow(
                "Goals", playerData["statistics"][0]["goals"]["total"]),
            _buildStatRow(
                "Assists", playerData["statistics"][0]["goals"]["assists"]),
            _buildStatRow(
                "Yellow Cards", playerData["statistics"][0]["cards"]["yellow"]),
            _buildStatRow(
                "Red Cards", playerData["statistics"][0]["cards"]["red"]),
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
