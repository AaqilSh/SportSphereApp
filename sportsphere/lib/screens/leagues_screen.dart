import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaguesScreen extends StatelessWidget {
  final List<Map<String, String>> leagues = [
    {"name": "Premier League", "logo": "assets/premier_league.png"},
    {"name": "CBF League", "logo": "assets/cbf_league.png"},
    {"name": "LIGUE 1 League", "logo": "assets/ligue1.png"},
    {"name": "Korean League", "logo": "assets/korean_league.png"},
    {"name": "La Liga", "logo": "assets/la_liga.png"},
    {"name": "Scottish League", "logo": "assets/scottish_league.png"},
    {"name": "Serie A", "logo": "assets/serie_a.png"},
    {"name": "Ligue 1", "logo": "assets/ligue1_uber.png"},
    {"name": "Eredivisie", "logo": "assets/eredivisie.png"},
    {"name": "MLS", "logo": "assets/mls.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Leagues",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Leagues",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child:
                      Text("View all >", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: leagues.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return _buildLeagueCard(leagues[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 🏆 League Card UI
  Widget _buildLeagueCard(Map<String, String> league) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          padding: EdgeInsets.all(10),
          child: Image.asset(league["logo"]!, width: 50, height: 50),
        ),
        SizedBox(height: 8),
        Text(league["name"]!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      iconSize: 25.0,
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house), label: "Leagues"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendarDays), label: "Schedule"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.peopleGroup), label: "Teams"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user), label: "Profile"),
      ],
    );
  }
}
