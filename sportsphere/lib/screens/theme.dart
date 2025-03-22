import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData appTheme = ThemeData(
  // primaryColor: Color(0xFF064C93), // Deep Blue
  scaffoldBackgroundColor: Color(0xffDAE4F2),
  // Light Grayish White
  cardColor: Colors.white, // Cards
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
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF064C93), // Primary Button
      foregroundColor: Colors.white, // Button Text
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff8C8CBF),
    // foregroundColor: Color(0xffF2E8DA),
  ),
);
