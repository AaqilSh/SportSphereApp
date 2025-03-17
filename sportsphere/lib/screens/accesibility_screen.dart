import 'package:flutter/material.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accessibility')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accessibility Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Enable High Contrast Mode'),
              value: false,
              onChanged: (bool value) {
                // Handle toggle
              },
            ),
            SwitchListTile(
              title: Text('Enable Screen Reader Support'),
              value: false,
              onChanged: (bool value) {
                // Handle toggle
              },
            ),
            SwitchListTile(
              title: Text('Increase Text Size'),
              value: false,
              onChanged: (bool value) {
                // Handle toggle
              },
            ),
          ],
        ),
      ),
    );
  }
}
