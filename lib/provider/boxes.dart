import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/user.dart';
import '../model/activity.dart';

class Boxes extends ChangeNotifier {
  static Box<User> getUsersBox() => Hive.box<User>('users');
  static Box<Activity> getActivityBox() => Hive.box<Activity>('activities');

  List<Activity> _activityData = [];

  List<Activity> get activities => _activityData;

  void getAllActivityValue(String searchKeyWord) {
    if (searchKeyWord == "") {
      _activityData = Hive.box<Activity>('activities').values.toList();
    } else {
      List<Activity> res = [];
      var values = Hive.box<Activity>('activities').values.toList();
      for (var element in values) {
        if (element.title.startsWith(searchKeyWord)) {
          res.add(element);
        }
      }
      _activityData = res;
    }
    notifyListeners();
  }

  void UpdateActivity(Activity activity, int index) {
    final box = Hive.box<Activity>('activities');
    box.deleteAt(index);
    box.putAt(index, activity);
    notifyListeners();
  }

  void deleteActivity(int index) {
    final box = Hive.box<Activity>('activities');
    box.deleteAt(index);
    notifyListeners();
  }
}
