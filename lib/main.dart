import 'package:clocklify/model/activity.dart';
import 'package:clocklify/model/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appPath = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appPath.path);
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  Hive.registerAdapter(ActivityAdapter());
  await Hive.openBox<Activity>('activities');
  runApp(MyApp());
}
