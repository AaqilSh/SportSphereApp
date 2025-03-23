import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  final List<Map<String, String>> faqData = [
    {
      "question": "How can I reset my password?",
      "answer":
          "Go to Settings > Account > Reset Password and follow the instructions."
    },
    {
      "question": "How do I contact support?",
      "answer":
          "You can email us at admin@sportsphere.com or call us at 123456789."
    },
    {
      "question": "Can I favorite teams or players?",
      "answer":
          "Yes! You can mark your favorite teams and players in the app settings."
    },
    {
      "question": "How frequently are match stats updated?",
      "answer": "Match stats are updated in real-time as the games progress."
    },
    {
      "question": "Does the app support multiple leagues?",
      "answer":
          "Yes, we support Premier League, La Liga, Bundesliga, Serie A, Ligue 1, and more!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FAQ")),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text(
                faqData[index]["question"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    faqData[index]["answer"]!,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
