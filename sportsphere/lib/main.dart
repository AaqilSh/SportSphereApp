import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportsphere/providers/team_provider.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCA98Zn2h10tpgzo7nQxwGORnoP0JL8e18",
        authDomain: "sportsphere-b2e9e.firebaseapp.com",
        projectId: "sportsphere-b2e9e",
        storageBucket: "sportsphere-b2e9e.firebasestorage.app",
        messagingSenderId: "470275251620",
        appId: "1:470275251620:web:3c9cd7bdd3e6bce592b531",
        measurementId: "G-0BLW2HVKVF"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TeamProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Adjust for your design reference
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SportSphere',
          theme: ThemeData(
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontSize: 16.sp,
                height: 1.5,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              titleLarge: TextStyle(
                fontSize: 24.sp,
                height: 29.sp / 24.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}
