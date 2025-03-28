import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms and Conditions",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "By using this application, you agree to abide by the following terms and conditions:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildTermItem("1. Acceptance of Terms",
                  "By accessing or using our app, you agree to be bound by these terms."),
              _buildTermItem("2. User Responsibilities",
                  "You are responsible for maintaining the confidentiality of your login credentials."),
              _buildTermItem("3. Prohibited Activities",
                  "You may not use the app for any unlawful or fraudulent activities."),
              _buildTermItem("4. Privacy Policy",
                  "Your use of the app is also governed by our Privacy Policy."),
              _buildTermItem("5. Changes to Terms",
                  "We reserve the right to modify these terms at any time."),
              SizedBox(height: 20),
              Text(
                "If you do not agree with any of these terms, please discontinue use of the app.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
