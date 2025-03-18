import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportsphere/screens/accesibility_screen.dart';
import 'package:sportsphere/screens/app_info_screen.dart';
import 'package:sportsphere/screens/customer_support_screen.dart';
import 'package:sportsphere/screens/favorite_players.screen.dart';
import 'package:sportsphere/screens/favorite_teams_screen.dart';
import 'package:sportsphere/screens/login_screen.dart';
import 'package:sportsphere/screens/notification_screen.dart';
import 'package:sportsphere/screens/privacy_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logout failed: $e")),
                    );
                  }
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
    final Map<String, Widget> routes = {
      'App info': AppInfoScreen(),
      'Privacy': PrivacySettingsScreen(),
      'Customer Support': CustomerSupportScreen(),
      'Accessibility': AccessibilityScreen(),
      'Notifications': NotificationSettingsScreen(),
    };

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        if (routes.containsKey(title)) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => routes[title]!),
          );
        }
      },
    );
  }
}
