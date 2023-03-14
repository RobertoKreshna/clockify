import 'package:clocklify/model/boxes.dart';
import 'package:clocklify/screen/home_timer.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../model/activity.dart';
import '../style/styles.dart';
import 'activity_detail.dart';

class ActivityScreen extends StatefulWidget {
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late List<Activity> activities = [];
  var searchKeyWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    activities = Boxes.getAllActivityValue(searchKeyWord.text);
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
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search Activity",
                        hintStyle: TextStyle(fontSize: 13),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Icon(Icons.search)),
                    controller: searchKeyWord,
                    onChanged: (value) {
                      activities = Boxes.getAllActivityValue(value);
                      setState(() {});
                    },
                  ),
                ))),
            Expanded(
                flex: 1,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 67, 75, 140),
                      filled: true,
                    ),
                  ),
                ))),
          ],
        ),
        Expanded(
          child: GroupedListView<dynamic, String>(
              elements: activities,
              groupBy: (element) => element.startDate,
              groupSeparatorBuilder: (String groupByValue) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(color: Style.timerLocation),
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                      dismissItem(context, direction, index);
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ActivityDetail(
                                            activities[index], index)))
                            .then((value) => refreshData());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Style.timerLocation))),
                        child: ListTile(
                          title: Text(
                            activities[index].duration,
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
                                            ' ${activities[index].startTime} - ${activities[index].endTime}',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12)),
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
                                activities[index].title,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
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
                                            ' ${activities[index].startTime} - ${activities[index].endTime}',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              }),
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

  void dismissItem(
      BuildContext context, DismissDirection direction, int index) {
    var box = Boxes.getActivityBox();
    box.delete(index);
  }
}
