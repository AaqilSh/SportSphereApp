import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportsphere/screens/p_new.dart';
import 'package:sportsphere/screens/profile_screen.dart';
import 'package:sportsphere/screens/standing_home.dart';
import 'package:sportsphere/screens/standings.dart';
import 'search_screen.dart';
import 'teams_screen.dart';
import 'schedule_screen.dart';
// import 'player_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Default screen index

  final List<Widget> _screens = [
    LeaguesScreen(),
    SearchScreen(),
    ScheduleScreen(),
    PlayersScreen(),
    StandingsScreen(),
    // StandingsPage(),
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
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        iconSize: 25.0,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house), label: "Teams"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass), label: "Search"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendarDays), label: "Schedule"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.peopleGroup), label: "Players"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.peopleGroup), label: "Standings"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user), label: "Profile"),
        ],
      ),
    );
  }
}
