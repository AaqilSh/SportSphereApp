import 'package:flutter/material.dart';
import 'package:sportsphere/screens/standings.dart';
import 'package:sportsphere/screens/top_assist_screen.dart';
import 'package:sportsphere/screens/top_scorer_screen.dart';

class StandingsAndStatsScreen extends StatelessWidget {
  final List<Map<String, String>> leagues = [
    {
      "idLeague": "39",
      "strLeague": "Premier League",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Premier_League_Logo.svg/1200px-Premier_League_Logo.svg.png"
    },
    {
      "idLeague": "140",
      "strLeague": "La Liga",
      "imageUrl":
          "https://brandlogos.net/wp-content/uploads/2021/01/la-liga-logo.png"
    },
    {
      "idLeague": "78",
      "strLeague": "Bundesliga",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/en/thumb/d/df/Bundesliga_logo_%282017%29.svg/800px-Bundesliga_logo_%282017%29.svg.png"
    },
    {
      "idLeague": "135",
      "strLeague": "Serie A",
      "imageUrl":
          "https://brandlogos.net/wp-content/uploads/2021/12/serie_a-brandlogo.net_-512x512.png"
    },
    {
      "idLeague": "61",
      "strLeague": "Ligue 1",
      "imageUrl":
          "https://images.seeklogo.com/logo-png/53/2/ligue-1-logo-png_seeklogo-535794.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Standings & Statistics
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Standings & Statistics'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Standings', icon: Icon(Icons.format_list_numbered)),
              Tab(text: 'Statistics', icon: Icon(Icons.bar_chart)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStandingsTab(context),
            _buildStatisticsTab(context),
          ],
        ),
      ),
    );
  }

  /// Standings Tab
  Widget _buildStandingsTab(BuildContext context) {
    return ListView.builder(
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xffDAF0F2),
          child: ListTile(
            leading: Image.network(
              leagues[index]['imageUrl']!,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported, size: 50);
              },
            ),
            title: Text(
              leagues[index]['strLeague']!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeagueStandingsScreen(
                    leagueId: leagues[index]['idLeague']!,
                    leagueName: leagues[index]['strLeague']!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Statistics Tab
  Widget _buildStatisticsTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          _buildStatCard(
            context,
            title: "Top Scorers",
            subtitle: "See the top goal scorers",
            icon: Icons.sports_soccer,
            screen: TopScorersScreen(),
          ),
          SizedBox(height: 16),
          _buildStatCard(
            context,
            title: "Top Assists",
            subtitle: "See players with the most assists",
            icon: Icons.handshake,
            screen: TopAssistsScreen(),
          ),
        ],
      ),
    );
  }

  /// Reusable Card Widget for Statistics
  Widget _buildStatCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required Widget screen}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.blueAccent),
        title: Text(title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle:
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}
