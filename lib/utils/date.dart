import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Time {
  static String getCurrentDate() {
    DateFormat formatter = DateFormat('dd MMM yy');
    String formatted = formatter.format(DateTime.now());
    return formatted;
  }

  static String getCurrentTime() {
    DateFormat formatter = DateFormat('hh : mm : ss');
    String formatted = formatter.format(DateTime.now());
    return formatted;
  }
}
