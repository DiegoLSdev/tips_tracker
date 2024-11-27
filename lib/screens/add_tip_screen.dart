import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import '../components/add_tip_dialog.dart';

class AddTipScreen extends StatefulWidget {
  const AddTipScreen({super.key});

  @override
  State<AddTipScreen> createState() => _AddTipScreenState();
}

class _AddTipScreenState extends State<AddTipScreen> {
  DateTime selectedDate =
      DateTime.now(); // Set the initial value to the current day
  int? selectedTipIndex; // To track which tip the user wants to edit

  // final foo = const TextStyle(color: Colors.teal) ;

  @override
  Widget build(BuildContext context) {
    // final tipProvider = Provider.of<TipProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Add Tip',
        style:  TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: const Color.fromRGBO(
            234, 234, 234, 1), // Set the background color here
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // Calendar Widget
              Container(
                decoration: BoxDecoration(
                  
                  color:  const Color.fromRGBO(255, 255, 255, 1), // Set the background color here
                  borderRadius: BorderRadius.circular(16),
                  // border: Border.all(
                  // Add border property here
                  // color: Colors.blue, // Border color
                  // width: 2.0, // Border width
                  // ),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    
                    selectedMonthTextStyle:
                        const TextStyle(color: Colors.teal),
                    yearTextStyle:
                        const TextStyle(color: Colors.teal),
                    monthTextStyle:
                        const TextStyle(color: Colors.teal),
                    dayTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    firstDayOfWeek: 1,
                    selectedDayTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    weekdayLabelTextStyle: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                    
                    selectedDayHighlightColor:
                         Colors.teal.withOpacity(0.19),
                    daySplashColor: Colors.blue
                  ),
                  value: [selectedDate],
                  onValueChanged: (dates) {
                    setState(() {
                      selectedDate =
                          dates.isNotEmpty ? dates.first : DateTime.now();
                    });
                  },
                ),
              ),

              const SizedBox(height: 25),

              AddTipDialog(
                selectedDate: selectedDate,
                onAddTip: () {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
