import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tips_app_from_scratch/controller/tip_provider.dart';
import 'package:tips_app_from_scratch/screens/home_screen.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tips App",
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
