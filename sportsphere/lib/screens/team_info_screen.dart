import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeamInfoScreen extends StatefulWidget {
  final int leagueId;
  final int teamId;
  const TeamInfoScreen({required this.leagueId, required this.teamId, super.key});

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
        "https://v3.football.api-sports.io/teams/statistics?league=${widget.leagueId}&team=${widget.teamId}&season=2023";

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
        title: Text(isLoading
            ? "Loading..."
            : teamData?['response']?['team']?['name'] ?? "Team Info"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : teamData == null || teamData!['response'] == null
              ? Center(child: Text("Failed to load team data"))
              : SingleChildScrollView(
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
                      SizedBox(height: 10),

                      // Team Name
                      Text(
                        teamData!['response']['team']['name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      // Fixtures
                      _buildSectionTitle("Fixtures"),
                      _buildStatCard([
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
                      ]),

                      _buildSectionTitle("Goals"),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildGoalStat(
                                "Goals For",
                                teamData!['response']['goals']['for']['total']
                                            ['total']
                                        ?.toString() ??
                                    "N/A",
                                teamData!['response']['goals']['for']['total']
                                            ['home']
                                        ?.toString() ??
                                    "N/A",
                                teamData!['response']['goals']['for']['total']
                                            ['away']
                                        ?.toString() ??
                                    "N/A",
                              ),
                              Divider(thickness: 1),
                              _buildGoalStat(
                                "Goals Against",
                                teamData!['response']['goals']['against']
                                            ['total']['total']
                                        ?.toString() ??
                                    "N/A",
                                teamData!['response']['goals']['against']
                                            ['total']['home']
                                        ?.toString() ??
                                    "N/A",
                                teamData!['response']['goals']['against']
                                            ['total']['away']
                                        ?.toString() ??
                                    "N/A",
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Form
                      _buildSectionTitle("Form"),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.center,
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: teamData!['response']['form']
                                  .split('')
                                  .map<Widget>((char) {
                                Color color = char == 'W'
                                    ? Colors.green
                                    : char == 'L'
                                        ? Colors.red
                                        : Colors.grey;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    char,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatCard(List<Widget> children) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

Widget _buildDetailedStatRow(
    String label, String total, String home, String away) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Total: $total", style: TextStyle(fontSize: 14)),
            Text("Home: $home",
                style: TextStyle(fontSize: 14, color: Colors.green)),
            Text("Away: $away",
                style: TextStyle(fontSize: 14, color: Colors.red)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildGoalItem(String label, String value) {
  return Column(
    children: [
      Text(label,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
      SizedBox(height: 4),
      Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _buildGoalStat(String title, String total, String home, String away) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildGoalItem("Total", total),
          _buildGoalItem("Home", home),
          _buildGoalItem("Away", away),
        ],
      ),
    ],
  );
}
