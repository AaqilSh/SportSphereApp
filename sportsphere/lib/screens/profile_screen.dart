import 'package:flutter/material.dart';

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
            _buildFavoriteOption("My Teams",
                "Follow your favorite teams for personalized content and recommendations."),
            _buildFavoriteOption("My Players",
                "Follow your favorite players for personalized content and recommendations."),
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

  Widget _buildFavoriteOption(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
      trailing: Icon(Icons.add, color: Colors.black),
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
