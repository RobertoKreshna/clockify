import 'dart:async';
import 'dart:core';

import 'package:clocklify/model/activity.dart';
import 'package:clocklify/model/boxes.dart';
import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  late Timer _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  String _startTime = "-";
  String _startDate = "-";
  String _endTime = "-";
  String _endDate = "-";
  bool _startAvailable = true;
  bool _stopAvailable = false;
  bool _resetAvailable = false;
  bool _saveAvailable = false;
  bool _deleteAvailable = false;

  int get hour => _hour;
  int get minute => _minute;
  int get second => _seconds;
  String get startTimeString => _startTime;
  String get startDateString => _startDate;
  String get endTimeString => _endTime;
  String get endDateString => _endDate;
  bool get startAvail => _startAvailable;
  bool get stopAvail => _stopAvailable;
  bool get resetAvail => _resetAvailable;
  bool get saveAvail => _saveAvailable;
  bool get deleteAvail => _deleteAvailable;

  String getCurrentTime() {
    String time = "";
    DateTime _today = DateTime.now();
    time =
        "${_today.hour.toString().padLeft(2, '0')} ${_today.minute.toString().padLeft(2, '0')} ${_today.second.toString().padLeft(2, '0')}";
    return time;
  }

  String getCurrentDate() {
    String date = "";
    DateTime _today = DateTime.now();
    String month = getMonth(_today.month);
    date = "${_today.day} ${month} ${_today.year}";
    return date;
  }

  String getMonth(int month) {
    String res = "";
    switch (month) {
      case 1:
        res = "Jan";
        break;
      case 2:
        res = "Feb";
        break;
      case 3:
        res = "Mar";
        break;
      case 4:
        res = "Apr";
        break;
      case 5:
        res = "May";
        break;
      case 6:
        res = "Jun";
        break;
      case 7:
        res = "Jul";
        break;
      case 8:
        res = "Aug";
        break;
      case 9:
        res = "Sep";
        break;
      case 10:
        res = "Oct";
        break;
      case 11:
        res = "Nov";
        break;
      case 12:
        res = "Des";
        break;
    }
    return res;
  }

  void setStart() {
    _startTime = getCurrentTime();
    _startDate = getCurrentDate();
    _startAvailable = false;
    _stopAvailable = true;
    _resetAvailable = true;
    notifyListeners();
  }

  void startTimer() {
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    setStart();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer.cancel();
    _endTime = getCurrentTime();
    _endDate = getCurrentDate();
    _saveAvailable = true;
    _deleteAvailable = true;
    _stopAvailable = false;
    _resetAvailable = false;
    notifyListeners();
  }

  void resetTimer() {
    _timer.cancel();
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    _startDate = "-";
    _startTime = "-";
    _endDate = "-";
    _endTime = "-";
    _startAvailable = true;
    _stopAvailable = false;
    _resetAvailable = false;
    notifyListeners();
  }

  void deleteCurrentTimerData() {
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    _startDate = "-";
    _startTime = "-";
    _endDate = "-";
    _endTime = "-";
    _deleteAvailable = false;
    _saveAvailable = false;
    _startAvailable = true;
    notifyListeners();
  }

  void saveCurrentTimerData(
      String title, String duration, String lat, String long) {
    //add
    final newActivity = Activity(
        title, duration, _startDate, _startTime, _endDate, _endTime, long, lat);
    final box = Boxes.getActivityBox();
    box.add(newActivity);
    //reset back the timer
    resetTimer();
  }
}
