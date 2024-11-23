import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/tip.dart';

class TipProvider extends ChangeNotifier {
  final List<Tip> _items = [];

  List<Tip> get items => _items;

  void addTip(Tip tip) {
    _items.add(tip);
    notifyListeners(); // Notify listeners about the change
  }

   void deleteTip(String formattedDate) {
    // Find and remove tips that match the provided date
    _items.removeWhere((tip) {
      final tipDate = DateFormat('yyyy-MM-dd').parse(tip.date);
      final tipFormattedDate = DateFormat('MMMM d').format(tipDate);
      return tipFormattedDate == formattedDate;
    });
    notifyListeners(); // Notify listeners to update the UI
  }
}
