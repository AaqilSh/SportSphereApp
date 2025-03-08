import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeamInfoScreen extends StatefulWidget {
  final int teamId; // Use team ID to fetch data

  TeamInfoScreen({required this.teamId});

  @override
  _TeamInfoScreenState createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen> {
  Map<String, dynamic>? teamData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTeamData();
  }

  Future<void> fetchTeamData() async {
    final String apiKey = "a0ae70bf7c6687247992d15ddff92bfb";
    final String apiUrl =
        "https://v3.football.api-sports.io/teams/statistics?league=39&team=33&season=2022";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'x-rapidapi-key': apiKey},
      );

      if (response.statusCode == 200) {
        setState(() {
          teamData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load team data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching team data: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FC),
      appBar: AppBar(
        title: Text(teamData?['response']?['team']?['name'] ?? "Loading..."),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : teamData == null || teamData!['response'] == null
              ? Center(child: Text("Failed to load team data"))
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Team Logo
                      Center(
                        child: Image.network(
                          teamData!['response']['team']['logo'],
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Team Name
                      Text(
                        teamData!['response']['team']['name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      // Fixtures
                      Text("Fixtures",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      _buildStatRow(
                          "Played",
                          teamData!['response']['fixtures']['played']['total']
                              .toString()),
                      _buildStatRow(
                          "Wins",
                          teamData!['response']['fixtures']['wins']['total']
                              .toString()),
                      _buildStatRow(
                          "Draws",
                          teamData!['response']['fixtures']['draws']['total']
                              .toString()),
                      _buildStatRow(
                          "Losses",
                          teamData!['response']['fixtures']['loses']['total']
                              .toString()),
                      SizedBox(height: 20),

                      // Goals
                      Text("Goals",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      _buildStatRow(
                          "Goals For",
                          teamData!['response']['goals']['for']['total']
                              .toString()),
                      _buildStatRow(
                          "Goals Against",
                          teamData!['response']['goals']['against']['total']
                              .toString()),
                      SizedBox(height: 20),

                      // Form
                      Text("Form",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Wrap(
                        children: teamData!['response']['form']
                            .split('')
                            .map<Widget>((char) {
                          Color color = char == 'W'
                              ? Colors.green
                              : char == 'L'
                                  ? Colors.red
                                  : Colors.grey;
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              char,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: color),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
