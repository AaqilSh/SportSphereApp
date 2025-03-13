import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportsphere/providers/team_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ADD THIS LINE
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
