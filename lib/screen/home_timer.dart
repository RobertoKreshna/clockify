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
      body: SafeArea(child: Consumer<TimerProvider>(
        builder: (context, timer, child) {
          return Column(children: [
            Spacer(),
            Container(
              child: Text(
                '${timer.hour.toString().padLeft(2, "0")} : ${timer.minute.toString().padLeft(2, "0")} : ${timer.second.toString().padLeft(2, "0")}',
                style: TextStyle(color: Colors.white, fontSize: 70),
              ),
            ),
            Spacer(),
            Component.StartEndActivity(
                timer.startTimeString,
                timer.startDateString,
                timer.endTimeString,
                timer.endDateString),
            Component.LocationBox(
              Consumer<GeoLocator>(
                builder: (context, location, child) {
                  location.getLocation();
                  return Text(
                    '${location.lat}, ${location.long}',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            Component.ActivityTitleBox(title),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  timer.startAvail != false
                      ? Component.blueButton('START', () {
                          timer.startTimer();
                        })
                      : Container(),
                  timer.stopAvail != false
                      ? Component.blueButton('STOP', () {
                          timer.stopTimer();
                        })
                      : Container(),
                  timer.resetAvail != false
                      ? Component.greyButton('RESET', () {
                          timer.resetTimer();
                          title.clear();
                        })
                      : Container(),
                  timer.saveAvail != false
                      ? Consumer<GeoLocator>(
                          builder: (context, location, child) {
                          return Component.blueButton('SAVE', () {
                            timer.saveCurrentTimerData(
                                title.text, location.lat, location.long);
                            title.clear();
                          });
                        })
                      : Container(),
                  timer.deleteAvail != false
                      ? Component.greyButton('DELETE', () {
                          timer.deleteCurrentTimerData();
                        })
                      : Container(),
                ],
              ),
            ),
          ]);
        },
      )),
    );
  }
}
