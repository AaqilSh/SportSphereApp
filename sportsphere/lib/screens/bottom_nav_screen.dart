import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile_screen.dart';
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
    PlayersScreen(),
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
        selectedItemColor: const Color.fromARGB(255, 0, 127, 231),
        unselectedItemColor: Colors.grey,
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
      ),
    );
  }
}
