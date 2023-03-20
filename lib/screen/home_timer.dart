import 'package:clocklify/model/timer.dart';
import 'package:clocklify/screen/activity.dart';
import 'package:clocklify/style/styles.dart';
import 'package:clocklify/provider/location_provider.dart';
import 'package:clocklify/utils/component.dart';
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
          return Component.StartEndActivity(value.startTimeString,
              value.startDateString, value.endTimeString, value.endDateString);
        }),
        Component.LocationBox(
          Consumer<GeoLocator>(
            builder: (context, value, child) {
              value.getLocation();
              return Text(
                '${value.lat}, ${value.long}',
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        Component.ActivityTitleBox(title),
        Consumer<TimerProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                value.startAvail != false
                    ? Component.blueButton('START', () {
                        value.startTimer();
                      })
                    : Container(),
                value.stopAvail != false
                    ? Component.blueButton('STOP', () {
                        value.stopTimer();
                      })
                    : Container(),
                value.resetAvail != false
                    ? Component.greyButton('RESET', () {
                        value.resetTimer();
                        title.clear();
                      })
                    : Container(),
                value.saveAvail != false
                    ? Consumer<GeoLocator>(builder: (context, location, child) {
                        return Component.blueButton('SAVE', () {
                          value.saveCurrentTimerData(
                              title.text, location.lat, location.long);
                          title.clear();
                        });
                      })
                    : Container(),
                value.deleteAvail != false
                    ? Component.greyButton('DELETE', () {
                        value.deleteCurrentTimerData();
                      })
                    : Container(),
              ],
            ),
          );
        }),
      ])),
    );
  }
}
