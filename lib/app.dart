import 'package:clocklify/model/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/login.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerProvider>(create: (_) => TimerProvider())
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
