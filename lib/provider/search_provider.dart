import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _value = "";

  String get values => _value;

  void setValue(String value) {
    _value = value;
    notifyListeners();
  }

  void searchChanged(String value) {
    _value = value;
    notifyListeners();
  }
}
