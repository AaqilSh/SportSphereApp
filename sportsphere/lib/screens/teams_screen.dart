import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'team_info_screen.dart';

class LeaguesScreen extends StatefulWidget {
  @override
  _LeaguesScreenState createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  final String apiKey = "a0ae70bf7c6687247992d15ddff92bfb";
  final Map<String, int> leagues = {
    "Premier League": 39,
  };

  Map<String, List<Map<String, dynamic>>> allTeams = {};
  bool isLoading = true;
  List<Map<String, dynamic>> favoriteTeams = [];

  @override
  void initState() {
    super.initState();
    fetchAllLeaguesTeams();
    loadFavoriteTeams();
  }

  Future<void> fetchAllLeaguesTeams() async {
    setState(() => isLoading = true);
    Map<String, List<Map<String, dynamic>>> tempAllTeams = {};
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
        tempAllTeams[entry.key] = (data['response'] as List<dynamic>)
            .map<Map<String, dynamic>>((team) {
          return {
            "leagueId": leagueId,
            "id": team['team']['id'],
            "name": team['team']['name'],
            "logo": team['team']['logo'],
          };
        }).toList();
      } else {
        tempAllTeams[entry.key] = [];
      }
    }).toList();

    await Future.wait(fetchTasks);
    setState(() {
      allTeams = tempAllTeams;
      isLoading = false;
    });
  }

  Future<void> loadFavoriteTeams() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoriteTeamsString = prefs.getString('favorite_teams');
    if (favoriteTeamsString != null) {
      setState(() {
        favoriteTeams =
            List<Map<String, dynamic>>.from(json.decode(favoriteTeamsString));
      });
    }
  }

  Future<void> toggleFavoriteTeam(Map<String, dynamic> team) async {
    final prefs = await SharedPreferences.getInstance();
    final teamExists =
        favoriteTeams.any((favTeam) => favTeam["id"] == team["id"]);

    setState(() {
      if (teamExists) {
        favoriteTeams.removeWhere((favTeam) => favTeam["id"] == team["id"]);
      } else {
        favoriteTeams.add(team);
      }
    });

    await prefs.setString('favorite_teams', json.encode(favoriteTeams));
  }

  bool isFavorite(int teamId) {
    return favoriteTeams.any((team) => team["id"] == teamId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Teams",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: allTeams.entries.map((entry) {
                  final String leagueName = entry.key;
                  final List<Map<String, dynamic>> teams = entry.value;

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
                          return _buildTeamCard(context, teamData);
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildTeamCard(BuildContext context, Map<String, dynamic> teamData) {
    final bool favorite = isFavorite(teamData['id']);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamInfoScreen(
              leagueId: teamData['leagueId'],
              teamId: teamData['id'],
            ),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    teamData['logo'],
                    width: constraints.maxWidth *
                        0.5, // Adjust image size dynamically
                    height: constraints.maxWidth * 0.5,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      teamData['name'],
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4),
                  IconButton(
                    iconSize: constraints.maxWidth *
                        0.2, // Adjust icon size dynamically
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: favorite ? Colors.red : Colors.black,
                    ),
                    onPressed: () => toggleFavoriteTeam(teamData),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
