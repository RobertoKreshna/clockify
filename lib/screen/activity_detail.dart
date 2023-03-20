import 'package:clocklify/model/boxes.dart';
import 'package:clocklify/model/timer.dart';
import 'package:clocklify/utils/component.dart';
import 'package:clocklify/utils/date.dart';
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
  var title = TextEditingController();

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
            Text(
              Time.getCurrentDate(),
              style: TextStyle(color: Colors.amber, fontSize: 16),
            ),
            Spacer(
              flex: 3,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Component.StartEndActivity(activity.startTime,
                    activity.startDate, activity.endTime, activity.endDate)),
            Component.LocationBox(
              Text(
                '${activity.lat}, ${activity.long}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Component.ActivityTitleBox(title, hint: activity.title),
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
