import 'package:clocklify/model/timer.dart';
import 'package:clocklify/provider/location_provider.dart';
import 'package:clocklify/provider/search_provider.dart';
import 'package:clocklify/provider/sort_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/login.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerProvider>(create: (_) => TimerProvider()),
        ChangeNotifierProvider<SortProvider>(create: (_) => SortProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<GeoLocator>(create: (_) => GeoLocator())
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
