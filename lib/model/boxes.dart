import 'package:hive/hive.dart';

import 'user.dart';
import 'activity.dart';

class Boxes {
  static Box<User> getUsersBox() => Hive.box<User>('users');
  static Box<Activity> getActivityBox() => Hive.box<Activity>('activities');

  static void getAllUserKey() {
    var values = Hive.box<User>('users').keys;
    for (var element in values) {
      print(element.toString());
    }
  }

  static void getAllUserValue() {
    var values = Hive.box<User>('users').values;
    for (var element in values) {
      print('nama');
      print(element.name);
      print('password');
      print(element.password);
    }
  }

  static List<Activity> getAllActivityValue(String searchKeyWord) {
    if (searchKeyWord == "") {
      return Hive.box<Activity>('activities').values.toList();
    } else {
      List<Activity> res = [];
      var values = Hive.box<Activity>('activities').values.toList();
      for (var element in values) {
        if (element.title.startsWith(searchKeyWord)) {
          res.add(element);
        }
      }
      return res;
    }
  }

  static UpdateActivity(Activity activity, int index) {
    final box = Hive.box<Activity>('activities');
    box.deleteAt(index);
    box.putAt(index, activity);
  }

  static deleteActivity(int index) {
    final box = Hive.box<Activity>('activities');
    box.deleteAt(index);
  }
}
