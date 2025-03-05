import 'package:flutter/material.dart';
import 'package:sportsphere/screens/favorite_players.screen.dart';
import 'package:sportsphere/screens/favorite_teams_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("TEAMS",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(),
            _buildFavoriteOption(
                context,
                "My Teams",
                "Follow your favorite teams for personalized content and recommendations.",
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoriteTeamsScreen()))),
            _buildFavoriteOption(
              context,
              "My Players",
              "Follow your favorite players for personalized content and recommendations.",
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritePlayersScreen())),
            ),
            SizedBox(height: 16),
            Text("Others Options",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(),
            _buildSettingsOption("Notifications"),
            _buildSettingsOption("Privacy"),
            _buildSettingsOption("Customer Support"),
            _buildSettingsOption("App info"),
            _buildSettingsOption("Accessibility"),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Implement logout function
                },
                child: Text("Logout",
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteOption(
      BuildContext context, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(title, style: TextStyle(fontWeight: FontWeight.w300)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  Widget _buildSettingsOption(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // Navigate to respective settings screen
      },
    );
  }
}
