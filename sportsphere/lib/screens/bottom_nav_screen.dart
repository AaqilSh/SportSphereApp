import 'package:flutter/material.dart';
import 'prodile_screen.dart';
import 'schedule_screen.dart';
import 'search_screen.dart';
import 'leagues_screen.dart';
import 'teams_screen.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    SearchScreen(),
    LeaguesScreen(),
    ScheduleScreen(),
    TeamsScreen(),
    ProfileScreen(),
  ];

  // Function to change index when tab is clicked
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer), label: "Leagues"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Schedule"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Teams"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
