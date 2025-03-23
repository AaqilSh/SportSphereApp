import 'package:flutter/material.dart';
import 'package:sportsphere/screens/faq_scree.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});
  final String supportEmail = "admin@sportsphere.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Support')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help you?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('Contact via Email'),
              onTap: () => launchUrlString(
                  "mailto:admin@sportsphere.com?subject=SportSphere&body=Contact%20support"),
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.phone, color: Colors.green),
                title: Text('Call Support'),
                onTap: () => launchUrlString("tel://123456789")),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.orange),
              title: Text('Visit FAQ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
