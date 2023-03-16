import 'package:clocklify/model/boxes.dart';
import 'package:clocklify/model/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../model/activity.dart';
import '../style/styles.dart';

class ActivityDetail extends StatelessWidget {
  var timer;
  Activity activity;
  var index;

  ActivityDetail(this.activity, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.bgColor,
        body: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                ),
                Text(
                  'DETAIL',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Consumer<TimerProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCurrentDate(),
                  style: TextStyle(color: Colors.amber, fontSize: 16),
                );
              },
            ),
            Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Start Time',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              '${activity.startTime}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Text(
                            '${activity.startDate}',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'End Time',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              '${activity.endTime}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Text(
                            '${activity.endDate}',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                tileColor: Style.timerLocation,
                leading: Icon(
                  Icons.location_on,
                  color: Colors.amber,
                  size: 30,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        '${activity.lat}, ${activity.long}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: '${activity.title}',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  minLines: 3,
                  maxLines: 5,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: Style.buttonColor,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            Boxes.UpdateActivity(activity, index);
                            Navigator.pop(context);
                          },
                          child: Text('SAVE'),
                        )),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            Boxes.deleteActivity(index);
                            Navigator.pop(context);
                          },
                          child: Text('DELETE',
                              style: TextStyle(color: Colors.black54)),
                        )),
                  ))
                ],
              ),
            )
          ],
        )));
  }
}
