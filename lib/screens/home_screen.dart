import 'package:flutter/material.dart';
import 'package:tips_tracker/screens/add_tip_screen.dart';
import 'package:tips_tracker/screens/yearly_and_monthly_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> body = [
    const AddTipScreen(),
    const MonthlyAndYearlyTipsScreen(), // Updated screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,  // Selected text/icon color 
        unselectedItemColor: Colors.white70, // Unselected text/icon color 
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
            icon: const Icon(Icons.add),
            backgroundColor: _currentIndex == 0 ? Colors.teal : Colors.red,  // Teal background for selected, red for unselected
          ),
          BottomNavigationBarItem(
            label: "Summary",
            icon: const Icon(Icons.calendar_today),
            backgroundColor: _currentIndex == 1 ? Colors.teal : Colors.red,  // Teal background for selected, red for unselected
          ),
        ],
      ),
    );
  }
}
