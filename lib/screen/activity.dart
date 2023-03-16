import 'package:clocklify/model/boxes.dart';
import 'package:clocklify/screen/home_timer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tuple/tuple.dart';

import '../model/activity.dart';
import '../style/styles.dart';
import 'activity_detail.dart';

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
  var currentValue = sortMethods.first;
  var currentLat, currentLong;

  _ActivityScreenState(this.currentLat, this.currentLong);

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
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Activity",
                          hintStyle: TextStyle(fontSize: 13),
                          suffixIcon: Icon(Icons.search),
                        ),
                        controller: searchKeyWord,
                        onChanged: (value) {
                          activities = Boxes.getAllActivityValue(value);
                          setState(() {});
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
                      child: DropdownButton<String>(
                        value: currentValue,
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
                          currentValue = value!;
                          refreshData();
                        },
                        items: sortMethods
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        dropdownColor: Style.timerLocation,
                      ),
                    ),
                  ))),
            ],
          ),
        ),
        Expanded(
          child: getActivity(currentValue),
        ),
      ])),
    );
  }

  void refreshData() {
    setState(() {});
  }

  Widget swipeLeft() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: Text(
        "DELETE",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget getActivity(String value) {
    if (value == "Latest Date") {
      return GroupedListView<dynamic, String>(
        elements: activities,
        groupBy: (element) => element.startDate,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        groupSeparatorBuilder: (String groupByValue) {
          return Container(
            decoration: BoxDecoration(color: Style.timerLocation),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                groupByValue,
                style: TextStyle(color: Colors.amber, fontSize: 12),
              ),
            ),
          );
        },
        indexedItemBuilder: (context, dynamic element, int index) {
          return Dismissible(
              direction: DismissDirection.endToStart,
              key: ObjectKey(this),
              background: swipeLeft(),
              onDismissed: (direction) {
                Boxes.deleteActivity(length - index - 1);
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ActivityDetail(element, length - index - 1)))
                      .then((value) => refreshData());
                },
                child: ListTile(
                  title: Text(
                    element.duration,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '',
                          children: [
                            WidgetSpan(
                                child: Icon(
                              Icons.timer,
                              color: Colors.white54,
                              size: 14,
                            )),
                            TextSpan(
                                text:
                                    ' ${element.startTime} - ${element.endTime} - ${element.startDate}',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        element.title,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '',
                          children: [
                            WidgetSpan(
                                child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white54,
                              size: 14,
                            )),
                            TextSpan(
                                text: ' ${element.lat}, ${element.long}',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
        separator: SizedBox.shrink(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(color: Colors.black45))),
            ),
          ),
        ),
        order: GroupedListOrder.DESC,
      );
    } else if (value == "Nearby") {
      List<double> distances = [];
      for (var element in activities) {
        var result = calculateDistance(
            double.parse(currentLat),
            double.parse(currentLong),
            double.parse(element.lat),
            double.parse(element.long));
        distances.add(result);
      }
      var combined = <Tuple2<double, dynamic>>[
        for (var i = 0; i < distances.length; i++)
          Tuple2(distances[i], activities[i]),
      ];
      combined.sort((tuple1, tuple2) {
        if (tuple1.item1 != tuple2.item1) {
          return tuple1.item1.compareTo(tuple2.item1);
        } else {
          var startDate1 = tuple1.item2.startDate.substring(0, 2);
          var startDate2 = tuple2.item2.startDate.substring(0, 2);
          return int.parse(startDate2).compareTo(int.parse(startDate1));
        }
      });
      var sortedActivity = [];
      for (var i = 0; i < combined.length; i++) {
        sortedActivity.add(combined[i].item2);
      }
      return ListView.builder(
        itemCount: sortedActivity.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              direction: DismissDirection.endToStart,
              key: ObjectKey(this),
              background: swipeLeft(),
              onDismissed: (direction) {
                Boxes.deleteActivity(length - index - 1);
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: Style.timerLocation,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            sortedActivity[index].startDate,
                            style: TextStyle(color: Colors.amber, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ActivityDetail(
                                  sortedActivity[index],
                                  length -
                                      index -
                                      1))).then((value) => refreshData());
                    },
                    child: ListTile(
                      title: Text(
                        sortedActivity[index].duration,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '',
                              children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.timer,
                                  color: Colors.white54,
                                  size: 14,
                                )),
                                TextSpan(
                                    text:
                                        ' ${sortedActivity[index].startTime} - ${sortedActivity[index].endTime}}',
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            sortedActivity[index].title,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white54,
                                  size: 14,
                                )),
                                TextSpan(
                                    text:
                                        ' ${sortedActivity[index].lat}, ${sortedActivity[index].long}',
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      );
    } else {
      return Container();
    }
  }

  double calculateDistance(double currentLat, double currentLong,
      double elementLat, double elementLong) {
    return Geolocator.distanceBetween(
        currentLat, currentLong, elementLat, elementLong);
  }
}
