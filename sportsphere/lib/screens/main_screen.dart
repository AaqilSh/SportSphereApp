import 'package:flutter/material.dart';
import 'package:sportsphere/screens/prodile_screen.dart';
import 'search_screen.dart';
import 'leagues_screen.dart';
import 'schedule_screen.dart';
import 'teams_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Default screen index

  final List<Widget> _screens = [
    SearchScreen(),
    LeaguesScreen(),
    ScheduleScreen(),
    TeamsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Show selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures labels always show
        selectedItemColor: Colors.black, // Highlighted icon color
        unselectedItemColor: Colors.grey, // Default icon color
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Leagues"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Schedule"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer), label: "Teams"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
