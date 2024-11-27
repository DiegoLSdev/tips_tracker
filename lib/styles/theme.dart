import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DarkStyles {
  static TextStyle title = const TextStyle(
    color:  Colors.red,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle title2 = const TextStyle(
    color:  Colors.red,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

    static TextStyle subtitleWhite = TextStyle(
    color:  Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

    static TextStyle subtitle1 = TextStyle(
    color:  Colors.teal,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

    static TextStyle subtitle2 = TextStyle(
    color:  const Color.fromARGB(255, 0, 112, 101),
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );








    static TextStyle mainNotFoundTitle = TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
    fontStyle: FontStyle.italic
  );

}

class AppTextStyles {
  static TextStyle mainTitle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
  );

  static TextStyle mainTitleSecondary = TextStyle(
    color: Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
  );

  static TextStyle subtitle = TextStyle(
    color: Colors.blue,
    fontSize: 16.sp,
  );

  static TextStyle subtitleSecondary = TextStyle(
    color: Colors.yellow,
    fontSize: 16.sp,
  );

  static TextStyle subtitleSecondaryShade300 = TextStyle(
    color: Colors.yellow.shade300,
    fontSize: 14.sp,
  );

  static TextStyle mainNotFoundTitle = TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
  );

  static TextStyle cardPriceText = TextStyle(
    color: Colors.purple,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
}

class LightFoo {
  // Predefined TextStyle for titles
  static TextStyle mainTitle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
  );

  // Predefined padding
  static EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(16.0);

  // Predefined padding for Row or Column
  static EdgeInsetsGeometry rowColumnPadding =
      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);

  // Predefined card style
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4), // changes position of shadow
      ),
    ],
  );

  // Predefined Column style
  static Column getCenteredColumn(Widget child) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [child],
    );
  }

  // Predefined Row style
  static Row getCenteredRow(Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [child],
    );
  }

  // Predefined Card widget with padding and decoration
  static Card getCard(Widget child) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
      child: Padding(
        padding: defaultPadding,
        child: child,
      ),
    );
  }
}

class AppTheme {
  // Define the light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.red,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.mainTitle, // Large display text
      displayMedium: AppTextStyles.mainTitleSecondary, // Medium display text
      bodyLarge: AppTextStyles.subtitle, // Large body text
      bodyMedium: AppTextStyles.subtitleSecondary, // Medium body text
      titleMedium: AppTextStyles.subtitleSecondaryShade300, // Medium title text
      labelSmall:
          AppTextStyles.mainNotFoundTitle, // Small labels (e.g., captions)
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.red,
      titleTextStyle: AppTextStyles.mainTitleSecondary,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.red.shade100,
    ),
    iconTheme: const IconThemeData(color: Colors.red),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Correct parameter for background color
        textStyle: AppTextStyles.mainTitleSecondary,
      ),
    ),
  );

  // Define the dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.mainTitle.copyWith(color: Colors.white70),
      displayMedium: AppTextStyles.mainTitleSecondary
          .copyWith(color: Colors.teal.shade200),
      bodyLarge: AppTextStyles.subtitle.copyWith(color: Colors.white60),
      bodyMedium:
          AppTextStyles.subtitleSecondary.copyWith(color: Colors.teal.shade300),
      titleMedium: AppTextStyles.subtitleSecondaryShade300
          .copyWith(color: Colors.teal.shade400),
      labelSmall:
          AppTextStyles.mainNotFoundTitle.copyWith(color: Colors.grey.shade500),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal.shade900,
      titleTextStyle:
          AppTextStyles.mainTitleSecondary.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade900,
      shadowColor: Colors.teal.shade800,
    ),
    iconTheme: IconThemeData(color: Colors.teal.shade300),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.teal.shade300,
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.teal.shade700, // Corrected background color for dark theme
        textStyle:
            AppTextStyles.mainTitleSecondary.copyWith(color: Colors.white),
      ),
    ),
  );
}
