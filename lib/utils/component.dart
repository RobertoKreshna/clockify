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

  static Widget ActivityTitleBox(TextEditingController title,
      {String hint = 'Write Your Activity Here'}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
        child: TextField(
          decoration: InputDecoration(
              hintText: hint,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          minLines: 3,
          maxLines: 5,
          controller: title,
        ));
  }

  static Widget LocationBox(Widget Child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        tileColor: Style.timerLocation,
        leading: Icon(
          Icons.location_on,
          color: Colors.amber,
          size: 30,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Child,
            ),
          ],
        ),
      ),
    );
  }

  static Widget StartEndActivity(
      String startTime, String startDate, String endTime, String endDate) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Start Time',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    startTime,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Text(
                  startDate,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              children: [
                Text(
                  'End Time',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    endTime,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Text(
                  endDate,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
