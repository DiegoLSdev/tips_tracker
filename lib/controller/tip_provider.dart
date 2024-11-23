import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/tip.dart';

class TipProvider extends ChangeNotifier {
  final List<Tip> _items = [];

  List<Tip> get items => _items;

  // Add a new tip
  void addTip(Tip tip) {
    _items.add(tip);
    notifyListeners();
  }

  // Delete tips based on date
  void deleteTip(String formattedDate) {
    _items.removeWhere((tip) {
      final tipDate = DateFormat('yyyy-MM-dd').parse(tip.date);
      final tipFormattedDate = DateFormat('MMMM d').format(tipDate);
      return tipFormattedDate == formattedDate;
    });
    notifyListeners();
  }

  // Clear all tips
  void clearAllTips() {
    _items.clear();
    notifyListeners();
  }

  // Edit an existing tip (if required later)
  void editTip(int index, Tip newTip) {
    if (index >= 0 && index < _items.length) {
      _items[index] = newTip;
      notifyListeners();
    }
  }
}
