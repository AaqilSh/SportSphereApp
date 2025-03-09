import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool dataSharing = false;
  bool personalizedAds = false;
  bool appAnalytics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Settings')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildPrivacyOption(
            title: 'Allow Data Sharing',
            value: dataSharing,
            onChanged: (newValue) {
              setState(() => dataSharing = newValue);
            },
          ),
          _buildPrivacyOption(
            title: 'Personalized Ads',
            value: personalizedAds,
            onChanged: (newValue) {
              setState(() => personalizedAds = newValue);
            },
          ),
          _buildPrivacyOption(
            title: 'App Analytics',
            value: appAnalytics,
            onChanged: (newValue) {
              setState(() => appAnalytics = newValue);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyOption({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
