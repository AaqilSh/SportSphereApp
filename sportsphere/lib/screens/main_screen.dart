import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sportsphere/screens/player_screen.dart';
import 'package:sportsphere/screens/players_screen.dart';
import 'package:sportsphere/screens/profile_screen.dart';
import 'package:sportsphere/screens/standing_home.dart';
import 'search_screen.dart';
import 'teams_screen.dart';
import 'schedule_screen.dart';

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
    StandingsAndStatsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Exit app if back is pressed
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Exit App"),
                content: Text("Are you sure you want to exit?"),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false), // Stay in app
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(true), // Exit app
                    child: Text("Yes"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffB4B4D5),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff0A121A),
          unselectedItemColor: Color(0xff537395),
          elevation: 2.0,
          iconSize: 18.0,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house), label: "Teams"),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(0, 198, 198, 224),
                icon: FaIcon(
                  FontAwesomeIcons.calendarDays,
                ),
                label: "Schedule"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.peopleGroup), label: "Squad"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.table), label: "Stats"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
