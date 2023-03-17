import 'package:clocklify/screen/activity.dart';
import 'package:clocklify/screen/home_timer.dart';
import 'package:clocklify/style/styles.dart';
import 'package:clocklify/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MainPageBar extends StatefulWidget {
  @override
  State<MainPageBar> createState() => _MainPageBarState();
}

class _MainPageBarState extends State<MainPageBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Style.bgColor,
        title: Image(
          image: AssetImage("assets/images/Logo.png"),
          width: 250,
        ),
        bottom: TabBar(
          tabs: [Text("TIMER"), Text("ACTIVITY")],
          controller: _tabController,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 17),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.amber,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 50),
        ),
      ),
      body: TabBarView(
        children: [HomeTimerPage(), ActivityScreen()],
        controller: _tabController,
      ),
    );
  }
}
