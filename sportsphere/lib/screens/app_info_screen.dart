import 'package:flutter/material.dart';
import 'package:sportsphere/screens/terms_condition.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text('App Name: SportSphere'),
            ),
            ListTile(
              leading: Icon(Icons.verified, color: Colors.green),
              title: Text('Version: 1.0.0'),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode, color: Colors.orange),
              title: Text('Developer: Aqil Shihab'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.description, color: Colors.purple),
              title: Text('Terms of Service'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsAndConditionsScreen()));
                // Navigate to Terms of Service
              },
            ),
          ],
        ),
      ),
    );
  }
}
