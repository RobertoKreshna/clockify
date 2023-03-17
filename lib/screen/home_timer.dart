import 'package:clocklify/model/timer.dart';
import 'package:clocklify/screen/activity.dart';
import 'package:clocklify/style/styles.dart';
import 'package:clocklify/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class HomeTimerPage extends StatefulWidget {
  @override
  State<HomeTimerPage> createState() => _HomeTimerPageState();
}

class _HomeTimerPageState extends State<HomeTimerPage> {
  late String duration;
  var title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      body: SafeArea(
          child: Column(children: [
        Spacer(),
        Consumer<TimerProvider>(builder: (context, value, child) {
          return Container(
            child: Text(
              '${value.hour.toString().padLeft(2, "0")} : ${value.minute.toString().padLeft(2, "0")} : ${value.second.toString().padLeft(2, "0")}',
              style: TextStyle(color: Colors.white, fontSize: 70),
            ),
          );
        }),
        Spacer(),
        Consumer<TimerProvider>(builder: (context, value, child) {
          return Padding(
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
                            '${value.startTimeString}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Text(
                          '${value.startDateString}',
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
                            '${value.endTimeString}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Text(
                          '${value.endDateString}',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
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
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Consumer<GeoLocator>(
                    builder: (context, value, child) {
                      value.getLocation();
                      return Text(
                        '${value.lat}, ${value.long}',
                        style: TextStyle(color: Colors.white),
                      );
                    },
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
                  hintText: 'Write Your Activity Here',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              minLines: 3,
              maxLines: 5,
              controller: title,
            )),
        Consumer<TimerProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                value.startAvail != false
                    ? Expanded(
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
                                value.startTimer();
                                title.clear();
                              },
                              child: Text('START'),
                            )),
                      ))
                    : Container(),
                value.stopAvail != false
                    ? Expanded(
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
                                value.stopTimer();
                                title.clear();
                              },
                              child: Text('STOP'),
                            )),
                      ))
                    : Container(),
                value.resetAvail != false
                    ? Expanded(
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
                                value.resetTimer();
                              },
                              child: Text(
                                'RESET',
                                style: TextStyle(color: Colors.black54),
                              ),
                            )),
                      ))
                    : Container(),
                value.saveAvail != false
                    ? Expanded(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: Style.buttonColor,
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                            child: Consumer<GeoLocator>(
                                builder: (context, location, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    onSurface: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                onPressed: () {
                                  value.saveCurrentTimerData(
                                      title.text, location.lat, location.long);
                                  title.clear();
                                },
                                child: Text('SAVE'),
                              );
                            })),
                      ))
                    : Container(),
                value.deleteAvail != false
                    ? Expanded(
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
                                value.deleteCurrentTimerData();
                              },
                              child: Text('DELETE',
                                  style: TextStyle(color: Colors.black54)),
                            )),
                      ))
                    : Container(),
              ],
            ),
          );
        }),
      ])),
    );
  }
}
