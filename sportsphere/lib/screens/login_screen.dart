import 'package:flutter/material.dart';
import 'package:sportsphere/main.dart';
import 'signup_screen.dart';
import 'bottom_nav_screen.dart'; // Import main app after login

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login Screen", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Bottom Navigation after login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavScreen()),
                );
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Signup Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
