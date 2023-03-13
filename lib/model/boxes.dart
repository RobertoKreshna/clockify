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
}
