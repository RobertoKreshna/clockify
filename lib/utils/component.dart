import 'package:flutter/material.dart';

import '../style/styles.dart';

class Component {
  static Widget blueButton(String text, Function pressed) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: Style.buttonColor,
            borderRadius: BorderRadius.circular(7.5),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: () {
              pressed();
            },
            child: Text('$text'),
          )),
    ));
  }

  static Widget greyButton(String text, Function pressed) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.5),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: () {
              pressed();
            },
            child: Text(
              '$text',
              style: TextStyle(color: Colors.black54),
            ),
          )),
    ));
  }
}
