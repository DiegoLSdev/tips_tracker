import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          Text(
            formatDate(widget.selectedDate),
            style: const TextStyle(
              color: Colors.teal,
              fontSize: 22
            ),
          ),

          const SizedBox(height: 15),


          // Amount Input
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centrar los grupos con menos separación
            crossAxisAlignment: CrossAxisAlignment.center, // Alinear verticalmente
            children: [
              CupertinoSlidingSegmentedControl<int>(
                groupValue: currencyIndex,
                backgroundColor: const Color.fromARGB(255, 74, 74, 74),
                thumbColor: Colors.teal,
                children: const <int, Widget>{
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '€',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

              const SizedBox(width: 20),

              Row(
                children: [
                  // Input Field
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: amountController,
                      textAlign: TextAlign.center,
                      showCursor: true,
                      cursorColor: Colors.teal,
                      cursorHeight: 20, // Coincide con el tamaño del texto
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                      ],
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        height: 1.0,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Amount',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          amount = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 10), // Espacio entre input y botón

                  // Add Button
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                      ),
                      onPressed: () {
                        // Ocultar el teclado
                        FocusScope.of(context).unfocus();

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
                          widget.onAddTip();
                          amountController.clear();

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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),




        ],
      ),
    );
  }
}
