import 'package:clocklify/style/styles.dart';
import 'package:flutter/material.dart';

List<String> sortMethods = ['Latest Date', 'Nearby'];

class SortButton extends StatefulWidget {
  @override
  State<SortButton> createState() => _SortButtonState();

  String getValue() {
    return _SortButtonState().currentValue;
  }
}

class _SortButtonState extends State<SortButton> {
  String currentValue = sortMethods.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Style.timerLocation,
          borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: DropdownButton<String>(
        value: currentValue,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.white,
        ),
        elevation: 16,
        underline: Container(
          height: 0,
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            currentValue = value!;
          });
        },
        items: sortMethods.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        dropdownColor: Style.timerLocation,
      ),
    );
  }
}
