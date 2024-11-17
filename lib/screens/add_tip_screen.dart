import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:tips_app_from_scratch/styles/theme.dart';
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
      appBar: AppBar(
        title: const Text(
          'Add Tip',
          style: AppTextStyles.mainTitle,
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white, // Set the background color here
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              // Calendar Widget
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color here
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    // Add border property here
                    color: Colors.teal, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    dayTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                    firstDayOfWeek: 1,
                    selectedDayTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    weekdayLabelTextStyle: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDayHighlightColor: Colors.teal,
                    daySplashColor: Colors.red.shade200,
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

              const SizedBox(height: 16),
              // Display the selected date
              // Text(
              //   DateFormat('yyyy-MM-dd').format(selectedDate).replaceAll("-", "."),
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.w600,
              //     fontSize: 18,
              //   ),
              // ),
              const SizedBox(height: 16),

              // Tip Input Form (This was previously in the AddTipDialog)
              AddTipDialog(
                selectedDate: selectedDate,
                onAddTip: () {
                  setState(() {
                    // Here you would set selectedTipIndex to null if you want to reset
                  });
                },
              ),
              // const SizedBox(height: 16),

              // Show Tips List
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: tipProvider.items.length,
              //     itemBuilder: (context, index) {
              //       final tip = tipProvider.items[index];
              //       return ListTile(
              //         title: Text(
              //           "Amount: ${tip.currency ? '€' : '\$'}${tip.amount}",
              //           style: const TextStyle(
              //             color: Colors.red,
              //             fontSize: 12
              //           ),
              //         ),
              //         trailing: Text("Date: ${tip.date}",
              //         style: const TextStyle(
              //           color: Colors.red,
              //           fontSize: 12
              //         ),),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
