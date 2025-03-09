import 'package:flutter/material.dart';
import 'package:sportsphere/screens/app_info_screen.dart';
import 'package:sportsphere/screens/favorite_players.screen.dart';
import 'package:sportsphere/screens/favorite_teams_screen.dart';
import 'package:sportsphere/screens/notification_scree.dart';
import 'package:sportsphere/screens/privacy_screen.dart';

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
            _buildSettingsOption("Notifications", context),
            _buildSettingsOption("Privacy", context),
            _buildSettingsOption("Customer Support", context),
            _buildSettingsOption("App info", context),
            _buildSettingsOption("Accessibility", context),
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

  Widget _buildSettingsOption(String title, BuildContext context) {
    return Builder(
      builder: (context) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppInfoScreen()),
          );
        },
      ),
    );
  }
}
