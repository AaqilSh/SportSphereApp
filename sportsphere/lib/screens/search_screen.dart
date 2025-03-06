import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportsphere/providers/team_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Teams')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Team',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                context.read<TeamProvider>().searchTeams(query);
              },
            ),
          ),
          Expanded(
            child: Consumer<TeamProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.teams.isEmpty) {
                  return Center(child: Text('No results found'));
                }
                return ListView.builder(
                  itemCount: provider.teams.length,
                  itemBuilder: (context, index) {
                    final team = provider.teams[index];
                    return Card(
                      child: ListTile(
                        title: Text(team.strTeam),
                        subtitle: Text(team.strLeague ?? ''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TeamDetailsScreen(team: team),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// TeamDetailsScreen
class TeamDetailsScreen extends StatelessWidget {
  final Team team;

  TeamDetailsScreen({required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(team.strTeam)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Added this to make content scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'League: ${team.strLeague}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              if (team.strStadium != null) Text('Stadium: ${team.strStadium}'),
              if (team.strKeywords != null)
                Text('Keywords: ${team.strKeywords}'),
              if (team.strWebsite != null)
                InkWell(
                  onTap: () {}, // Add actual website link handling
                  child: Text(
                    'Website: ${team.strWebsite}',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              SizedBox(height: 10),
              if (team.strDescriptionEN != null)
                Text(
                  'Description: ${team.strDescriptionEN}',
                  softWrap: true, // Ensures text wraps properly
                ),
            ],
          ),
        ),
      ),
    );
  }
}
