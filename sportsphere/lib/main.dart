import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportsphere/providers/contrast_provider.dart';
import 'package:sportsphere/providers/font_size_provider.dart';
import 'package:sportsphere/providers/player_provider.dart';
import 'package:sportsphere/providers/team_provider.dart';
import 'package:sportsphere/providers/venue_provider.dart';
import 'package:sportsphere/screens/theme.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fontSizeProvider = FontSizeProvider();
  await fontSizeProvider.loadFontSize();
  final contrastProvider = ContrastProvider();
  await contrastProvider.loadContrast();
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
  SemanticsBinding.instance.ensureSemantics();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => fontSizeProvider),
        ChangeNotifierProvider(create: (context) => contrastProvider),
        ChangeNotifierProvider(create: (context) => TeamProvider()),
        ChangeNotifierProvider(create: (context) => PlayerProvider()),
        ChangeNotifierProvider(create: (context) => VenueProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ContrastProvider, FontSizeProvider>(
      builder: (context, contrastProvider, fontSizeProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812), // Adjust for your design reference
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SportSphere',
              theme: getTheme(contrastProvider.isHighContrast,
                  fontSizeProvider.isSizeIncreased),
              home: const LoginScreen(),
            );
          },
        );
      },
    );
  }
}
