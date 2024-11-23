import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle mainTitle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
  );

  static TextStyle mainTitleSecondary = TextStyle(
    color: Colors.teal,
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
  );

  static TextStyle subtitle = TextStyle(
    color: Colors.teal.shade300,
    fontSize: 16.sp,
  );

  static TextStyle mainNotFoundTitle = TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
  );

  static TextStyle cardPriceText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 14.sp),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 14.sp),
    ),
  );
}
