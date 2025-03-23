import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportsphere/screens/login_screen.dart';
import 'package:sportsphere/screens/main_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading state
        }
        if (snapshot.hasData) {
          return MainScreen(); // User is logged in
        }
        return LoginScreen(); // User is NOT logged in
      },
    );
  }
}
