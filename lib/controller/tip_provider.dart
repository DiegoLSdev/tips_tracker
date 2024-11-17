import 'package:flutter/material.dart';
import '../model/tip.dart';

class TipProvider extends ChangeNotifier {
  final List<Tip> _items = [];

  List<Tip> get items => _items;

  void addTip(Tip tip) {
    _items.add(tip);
    notifyListeners(); // Notify listeners about the change
  }
}
