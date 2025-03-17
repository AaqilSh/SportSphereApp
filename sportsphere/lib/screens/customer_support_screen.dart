import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

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
              onTap: () {
                // Implement email support logic
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('Call Support'),
              onTap: () {
                // Implement call support logic
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.orange),
              title: Text('Visit FAQ'),
              onTap: () {
                // Navigate to FAQ section
              },
            ),
          ],
        ),
      ),
    );
  }
}
