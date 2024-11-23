import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tips_tracker/screens/add_tip_screen.dart';
import 'package:tips_tracker/screens/yearly_and_monthly_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;

    void _handleAddTip() {
    // Por ahora, puede estar vacío o incluir lógica como un refresco.
    setState(() {});
  }

  final List<Widget> body = [
    const AddTipScreen(),
    const MonthlyAndYearlyTipsScreen(), // Updated screen
  ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: body[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      backgroundColor: Colors.teal,
      currentIndex: _currentIndex,
      onTap: (int newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: "Add Tip",
          icon: Icon(Icons.add, size: 24.sp), // Icono escalable
        ),
        BottomNavigationBarItem(
          label: "Summary",
          icon: Icon(Icons.calendar_today, size: 24.sp),
        ),
      ],
    ),
  );
}

}
