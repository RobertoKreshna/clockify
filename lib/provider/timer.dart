import 'dart:async';
import 'dart:core';

import 'package:clocklify/model/activity.dart';
import 'package:clocklify/utils/date.dart';
import 'package:flutter/foundation.dart';

import '../model/boxes.dart';

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

  void setStart() {
    _startTime = Time.getCurrentTime();
    _startDate = Time.getCurrentDate();
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
    _endTime = Time.getCurrentTime();
    _endDate = Time.getCurrentDate();
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

  void saveCurrentTimerData(String title, String lat, String long) {
    //add
    final duration =
        '${_hour.toString().padLeft(2, "0")} : ${_minute.toString().padLeft(2, "0")} : ${_seconds.toString().padLeft(2, "0")}';
    final newActivity = Activity(
        title, duration, _startDate, _startTime, _endDate, _endTime, long, lat);
    final box = Boxes.getActivityBox();
    box.add(newActivity);
    //reset back the timer
    _saveAvailable = false;
    _deleteAvailable = false;
    resetTimer();
  }
}
