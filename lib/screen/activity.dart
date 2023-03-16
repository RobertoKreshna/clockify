import 'package:clocklify/model/boxes.dart';
import 'package:clocklify/provider/search_provider.dart';
import 'package:clocklify/provider/sort_provider.dart';
import 'package:clocklify/screen/home_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/activity.dart';
import '../style/styles.dart';

List<String> sortMethods = ['Latest Date', 'Nearby'];

class ActivityScreen extends StatefulWidget {
  var lat, long;
  ActivityScreen(this.lat, this.long);
  @override
  State<ActivityScreen> createState() => _ActivityScreenState(lat, long);
}

class _ActivityScreenState extends State<ActivityScreen> {
  late List<Activity> activities = [];
  var length;
  var searchKeyWord = TextEditingController();
  var currentLat, currentLong, sort;

  _ActivityScreenState(this.currentLat, this.currentLong);

  @override
  void initState() {
    super.initState();
    sort = Provider.of<SortProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    activities = Boxes.getAllActivityValue(searchKeyWord.text);
    length = activities.length;
    return Scaffold(
      backgroundColor: Style.bgColor,
      body: SafeArea(
          child: Column(children: [
        Center(
          child: Container(
            width: 200,
            child: Image(image: AssetImage("assets/images/Logo.png")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          child: Container(
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeTimerPage()));
                  },
                  child: Text(
                    'TIMER',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                    ),
                  ),
                ))),
                Expanded(
                    child: Center(
                        child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.amber, width: 2))),
                  child: TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(
                      'ACTIVITY',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ))),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      child: Consumer<SearchProvider>(
                        builder: (context, search, child) {
                          return TextField(
                            decoration: InputDecoration(
                              hintText: "Search Activity",
                              hintStyle: TextStyle(fontSize: 13),
                              suffixIcon: Icon(Icons.search),
                            ),
                            controller: searchKeyWord,
                            onChanged: (value) {
                              search.setValue(value);
                            },
                          );
                        },
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Style.timerLocation,
                          borderRadius: BorderRadius.circular(10.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      child: Consumer<SortProvider>(
                        builder: (context, value, child) {
                          return DropdownButton<String>(
                            value: value.value,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            elevation: 16,
                            underline: Container(
                              height: 0,
                            ),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (String? value) {
                              sort.setValue(value!);
                            },
                            items: sortMethods
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            dropdownColor: Style.timerLocation,
                          );
                        },
                      ),
                    ),
                  ))),
            ],
          ),
        ),
        Consumer2<SortProvider, SearchProvider>(
          builder: (context, sort, search, child) {
            activities = Boxes.getAllActivityValue(search.values);
            return Expanded(
              child: SortProvider().sortActivity(
                  activities, sort.value, currentLat, currentLong),
            );
          },
        ),
      ])),
    );
  }
}
