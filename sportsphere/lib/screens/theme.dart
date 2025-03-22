import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getTheme(bool isHighContrast, bool isSizeIncreased) {
  double baseFontSize = isSizeIncreased ? 16.0 : 12.0;

  if (isHighContrast) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.yellow,
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontSize: (baseFontSize - 4).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: baseFontSize.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: (baseFontSize + 2).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: (baseFontSize + 4).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: (baseFontSize + 6).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: (baseFontSize + 8).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      primaryTextTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
      colorScheme: ColorScheme.dark(
        primary: Colors.yellow,
        onPrimary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        elevation: 4,
        titleTextStyle: TextStyle(
          fontSize: (baseFontSize + 6).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          color: Colors.yellow,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              color: Colors.yellow.withOpacity(0.8),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: Colors.yellow,
        shadowColor: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  } else {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xffDAE4F2),
      cardColor: Colors.white,
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontSize: (baseFontSize - 2).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: baseFontSize.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: (baseFontSize + 2).sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontSize: (baseFontSize + 6).sp, // Reduced from +8
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF064C93),
          foregroundColor: Colors.white,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff8C8CBF),
        elevation: 2,
        titleTextStyle: TextStyle(
          fontSize: (baseFontSize + 4).sp, // Reduced from +6
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: 1.1,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: Color(0xffDAF0F2),
        shadowColor: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
