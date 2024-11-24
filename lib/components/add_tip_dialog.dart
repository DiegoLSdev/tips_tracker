import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:tips_tracker/styles/theme.dart';
import '../controller/tip_provider.dart';
import '../model/tip.dart';

class AddTipDialog extends StatefulWidget {
  final DateTime? selectedDate;
  final VoidCallback onAddTip;

  const AddTipDialog({super.key, this.selectedDate, required this.onAddTip});

  @override
  State<AddTipDialog> createState() => _AddTipDialogState();
}

class _AddTipDialogState extends State<AddTipDialog> {
  int currencyIndex = 0; // 0: Euro, 1: Dollar
  double amount = 0.0;
  final TextEditingController amountController =
      TextEditingController(); // Controller for amount input

  String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat("d 'of' MMMM, yyyy").format(date).replaceAllMapped(
        RegExp(r'(\d+)(?=\s(of)\s)'),
        (Match match) =>
            "${match.group(1)}${_getOrdinalSuffix(int.parse(match.group(1)!))}");
  }

  String _getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) return "th";
    switch (number % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  @override
  Widget build(BuildContext context) {
    final tipProvider = Provider.of<TipProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          // Display Selected Date
          Text(
            formatDate(widget.selectedDate),
            style: DarkStyles.title2,
          ),
          const SizedBox(height: 24),

          // Currency Selector
          CupertinoSlidingSegmentedControl<int>(
            groupValue: currencyIndex,
            backgroundColor: const Color.fromARGB(255, 74, 74, 74),
            thumbColor: Colors.teal,
            children: <int, Widget>{
              0: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '€',
                  style: DarkStyles.title,
                ),
              ),
              1: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '\$',
                  style: DarkStyles.title,
                ),
              ),
            },
            onValueChanged: (int? newValue) {
              if (newValue != null) {
                setState(() {
                  currencyIndex = newValue;
                });
              }
            },
          ),
          const SizedBox(height: 40),

          // Amount Input
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers the children horizontally
            children: [
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextField(
                  controller: amountController,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.teal,
                  // cursorHeight: 20,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  style: const TextStyle(color: Colors.teal, fontSize: 24),
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                    ),
                    contentPadding: EdgeInsets.only(
                        bottom: 16), // Adds space between hint and underline
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      amount = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 60,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: () {
                    if (widget.selectedDate != null && amount > 0) {
                      tipProvider.addTip(
                        Tip(
                          amount: amount,
                          currency: currencyIndex == 0,
                          date: widget.selectedDate!
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                        ),
                      );
                      widget.onAddTip(); // Callback to refresh if needed
                      amountController.clear();

                      // Show a success Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Tip successfully added!',
                            style: TextStyle(color: Colors.teal, fontSize: 16),
                          ),
                          backgroundColor: Colors.white,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
