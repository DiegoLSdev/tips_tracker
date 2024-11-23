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

  @override
  Widget build(BuildContext context) {
    final tipProvider = Provider.of<TipProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          // Display Selected Date
          Text(
            DateFormat('yyyy-MM-dd')
                .format(widget.selectedDate ?? DateTime.now())
                .replaceAll("-", "."),
            style: AppTextStyles.mainTitleSecondary,
          ),
          const SizedBox(height: 16),

          // Currency Selector
          CupertinoSlidingSegmentedControl<int>(
            groupValue: currencyIndex,
            backgroundColor: Colors.teal.withOpacity(0.2),
            thumbColor: Colors.teal,
            children:  <int, Widget>{
              0: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '€',
                  style: AppTextStyles.mainTitle,
                ),
              ),
              1: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '\$',
                  style: AppTextStyles.mainTitle,
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
                  textAlign: TextAlign.center,
                  cursorColor: Colors.teal,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  style: const TextStyle(
                    color: Colors.teal,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    hintStyle: TextStyle(color: Colors.teal),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
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
              const SizedBox(height: 25),
              SizedBox(
                width: 50,
                height: 30,
                child: FloatingActionButton(
                  backgroundColor: Colors.teal,
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

                      // Show a success Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tip successfully added!',style: TextStyle(color: Colors.teal),),
                          backgroundColor: Colors.white,
                          duration: Duration(seconds: 2),
                          
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
