import 'package:flutter/material.dart';
import 'package:sportsphere/providers/player_provider.dart';

class PlayerDetailsScreen extends StatelessWidget {
  final Player player;

  const PlayerDetailsScreen({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.strPlayer),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (player.strCutout.isNotEmpty)
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(player.strCutout),
              ),
            SizedBox(height: 16),
            Text(
              player.strPlayer,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              player.strTeam,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              '${player.strPosition} - ${player.strNationality}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Born: ${player.dateBorn}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
