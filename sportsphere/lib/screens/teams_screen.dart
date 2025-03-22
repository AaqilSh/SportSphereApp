import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'team_info_screen.dart';

class LeaguesScreen extends StatefulWidget {
  const LeaguesScreen({super.key});

  @override
  _LeaguesScreenState createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  final String apiKey = "a0ae70bf7c6687247992d15ddff92bfb";
  final Map<String, int> leagues = {"Premier League": 39};

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
    await Future.wait(leagues.entries.map((entry) async {
      final int leagueId = entry.value;
      final response = await http.get(
        Uri.parse(
            "https://v3.football.api-sports.io/teams?league=$leagueId&season=2023"),
        headers: {'x-rapidapi-key': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        tempAllTeams[entry.key] = (data['response'] as List<dynamic>)
            .map<Map<String, dynamic>>((team) => {
                  "leagueId": leagueId,
                  "id": team['team']['id'],
                  "name": team['team']['name'],
                  "logo": team['team']['logo'],
                })
            .toList();
      } else {
        tempAllTeams[entry.key] = [];
      }
    }));

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
      teamExists
          ? favoriteTeams.removeWhere((favTeam) => favTeam["id"] == team["id"])
          : favoriteTeams.add(team);
    });

    await prefs.setString('favorite_teams', json.encode(favoriteTeams));
  }

  bool isFavorite(int teamId) =>
      favoriteTeams.any((team) => team["id"] == teamId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffDAE4F2),
      appBar: AppBar(title: const Text("Teams"), centerTitle: true),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: allTeams.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.key,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entry.value.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) =>
                            _buildTeamCard(entry.value[index]),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildTeamCard(Map<String, dynamic> teamData) {
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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        color: Color(0xffDAF0F2),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(teamData['logo'],
                  width: 80, height: 80, fit: BoxFit.contain),
              const SizedBox(height: 8),
              Text(
                teamData['name'],
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              IconButton(
                icon: Icon(favorite ? Icons.favorite : Icons.favorite_border,
                    color: favorite ? Colors.red : Colors.black),
                onPressed: () => toggleFavoriteTeam(teamData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
