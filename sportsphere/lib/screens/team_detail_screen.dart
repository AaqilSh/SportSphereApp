import 'package:flutter/material.dart';
import 'package:sportsphere/providers/team_provider.dart';

class TeamDetailsScreen extends StatelessWidget {
  final Team team;

  const TeamDetailsScreen({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(team.strTeam)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Semantics(
            label: "Team details screen for ${team.strTeam}",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: "League: ${team.strLeague}",
                  child: Text(
                    'League: ${team.strLeague}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Semantics(
                  label: "Stadium: ${team.strStadium}",
                  child: Text('Stadium: ${team.strStadium}'),
                ),
                Semantics(
                  label: "Keywords: ${team.strKeywords}",
                  child: Text('Keywords: ${team.strKeywords}'),
                ),
                Semantics(
                  label: "Visit the official website of ${team.strTeam}",
                  button: true, // Indicates it's a tappable element
                  child: InkWell(
                    onTap: () {
                      // Add actual website link handling
                    },
                    child: Text(
                      'Website: ${team.strWebsite}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Semantics(
                  label: "Team Description",
                  child: Text(
                    team.strDescriptionEN!,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
