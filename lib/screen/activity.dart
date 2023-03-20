import 'package:clocklify/model/boxes.dart';
import 'package:clocklify/provider/search_provider.dart';
import 'package:clocklify/provider/sort_provider.dart';
import 'package:clocklify/screen/home_timer.dart';
import 'package:clocklify/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../model/activity.dart';
import '../style/styles.dart';

List<String> sortMethods = ['Latest Date', 'Nearby'];

class ActivityScreen extends StatefulWidget {
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late List<Activity> activities = [];

  var sort;
  var searchKeyWord = TextEditingController();

  @override
  void initState() {
    super.initState();
    sort = Provider.of<SortProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
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
        Consumer3<SortProvider, SearchProvider, GeoLocator>(
          builder: (context, sort, search, location, child) {
            location.getLocation();
            activities = Boxes.getAllActivityValue(search.values);
            return Expanded(
              child: SortProvider().sortActivity(
                  activities, sort.value, location.lat, location.long),
            );
          },
        ),
      ])),
    );
  }
}
