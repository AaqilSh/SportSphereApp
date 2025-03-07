import 'package:flutter/material.dart';

class TeamInfoScreen extends StatelessWidget {
  final dynamic teamData;

  TeamInfoScreen({required this.teamData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FC),
      appBar: AppBar(
        title: Text(teamData['team']['name']),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Team Logo
            Center(
              child: Image.network(
                teamData['team']['logo'],
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),

            // Team Name
            Text(
              teamData['team']['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Country
            Text(
              "Country: ${teamData['team']['country']}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),

            // Stadium Information
            teamData['venue'] != null
                ? Column(
                    children: [
                      Text(
                        "Stadium: ${teamData['venue']['name']}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                        teamData['venue']['image'],
                        width: 250,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                : Text("Stadium information not available",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
