import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> allTeams = [
    {
      "name": "Manchester United",
      "country": "England",
      "logo": "assets/manu.png"
    },
    {
      "name": "Manchester City",
      "country": "England",
      "logo": "assets/mancity.png"
    },
  ];
  List<Map<String, String>> filteredTeams = [];

  @override
  void initState() {
    super.initState();
    filteredTeams = allTeams;
  }

  void _filterTeams(String query) {
    setState(() {
      filteredTeams = allTeams
          .where((team) =>
              team["name"]!.toLowerCase().contains(query.toLowerCase()) ||
              team["country"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: _buildBottomNavBar(),
      backgroundColor: Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Search",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // 🔍 Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterTeams,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Team, sport or venue",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 📌 Search Results (Team Cards)
            Expanded(
              child: ListView.builder(
                itemCount: filteredTeams.length,
                itemBuilder: (context, index) {
                  final team = filteredTeams[index];
                  return _buildTeamCard(team);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🏆 Team Card UI
  Widget _buildTeamCard(Map<String, String> team) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset(team["logo"]!, width: 40, height: 40),
        title: Text(team["name"]!,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Text(team["country"]!, style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
