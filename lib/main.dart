import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tips_tracker/controller/tip_provider.dart';
import 'package:tips_tracker/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TipProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // Base diseño móvil
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Tips App",
          theme: ThemeData(primarySwatch: Colors.teal),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
