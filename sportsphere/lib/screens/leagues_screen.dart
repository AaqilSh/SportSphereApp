import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'team_info_screen.dart'; // Import the new page

class LeaguesScreen extends StatefulWidget {
  @override
  _LeaguesScreenState createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  final String apiKey = "a0ae70bf7c6687247992d15ddff92bfb";
  final Map<String, int> leagues = {
    "Premier League": 39,
    "La Liga": 735,
    "Bundesliga": 78,
    "Serie A": 135,
    "Ligue 1": 61,
    "Eredivisie": 88,
  };

  Future<Map<String, List<Map<String, dynamic>>>> fetchAllLeaguesTeams() async {
    Map<String, List<Map<String, dynamic>>> allTeams = {};

    List<Future<void>> fetchTasks = leagues.entries.map((entry) async {
      final int leagueId = entry.value;
      final String url =
          "https://v3.football.api-sports.io/teams?league=$leagueId&season=2023";
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-rapidapi-key': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        allTeams[entry.key] = (data['response'] as List<dynamic>)
            .map<Map<String, dynamic>>((team) {
          return {
            "leagueId": leagueId, // ✅ Store league ID properly
            "team": team['team'], // ✅ Store team details
          };
        }).toList();
      } else {
        allTeams[entry.key] = [];
      }
    }).toList();

    await Future.wait(fetchTasks);
    return allTeams;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Leagues",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
          future: fetchAllLeaguesTeams(), // ✅ Corrected type
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final allTeams = snapshot.data ?? {};
              return ListView(
                children: allTeams.entries.map((entry) {
                  final String leagueName = entry.key;
                  final List<Map<String, dynamic>> teams =
                      entry.value; // ✅ Corrected type

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leagueName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: teams.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          final teamData = teams[index];
                          return _buildTeamCard(context, teamData['leagueId'],
                              teamData['team']); // ✅ Pass correct values
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildTeamCard(
    BuildContext context, int leagueId, Map<String, dynamic> teamData) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeamInfoScreen(
            leagueId: leagueId, // ✅ Pass league ID
            teamId: teamData['id'], // ✅ Pass team ID
          ),
        ),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            teamData['logo'],
            width: 50,
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            teamData['name'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
