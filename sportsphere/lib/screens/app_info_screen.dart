import 'package:flutter/material.dart';

class AppInfoScreen extends StatelessWidget {
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
              title: Text('App Name: Sports Tracker'),
            ),
            ListTile(
              leading: Icon(Icons.verified, color: Colors.green),
              title: Text('Version: 1.0.0'),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode, color: Colors.orange),
              title: Text('Developer: Your Company Name'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.description, color: Colors.purple),
              title: Text('Terms of Service'),
              onTap: () {
                // Navigate to Terms of Service
              },
            ),
          ],
        ),
      ),
    );
  }
}
