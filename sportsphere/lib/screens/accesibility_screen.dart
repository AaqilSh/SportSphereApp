import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportsphere/providers/contrast_provider.dart';
import 'package:sportsphere/providers/font_size_provider.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var fontSizeProvider = Provider.of<FontSizeProvider>(context);
    var contrastProvider = Provider.of<ContrastProvider>(context);

    double fontSize = Provider.of<FontSizeProvider>(context).fontSize;
    return Scaffold(
      appBar: AppBar(title: Text('Accessibility')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accessibility Settings',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Enable High Contrast Mode'),
              value: contrastProvider.isHighContrast,
              onChanged: (bool value) {
                contrastProvider.toggleContrast();
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
              value: fontSize > 16.0,
              onChanged: (bool value) {
                fontSizeProvider.setFontSize(value ? 20.0 : 16.0);

                // Handle toggle
              },
            ),
          ],
        ),
      ),
    );
  }
}
