import 'package:flutter/material.dart';

class Style {
  static final Color bgColor = Color.fromARGB(255, 37, 54, 123);
  static final LinearGradient buttonColor = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color.fromARGB(255, 69, 205, 220),
        Color.fromARGB(255, 46, 190, 217),
      ]);
  static final Color timerLocation = Color.fromARGB(255, 67, 75, 140);
}
