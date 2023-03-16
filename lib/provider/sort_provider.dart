import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tuple/tuple.dart';

import '../model/activity.dart';
import '../model/boxes.dart';
import '../screen/activity_detail.dart';
import '../style/styles.dart';
import '../utils/geolocation.dart';

class SortProvider extends ChangeNotifier {
  late var _value = "Latest Date";

  String get value => _value;

  void setValue(String value) {
    this._value = value;
    notifyListeners();
  }

  Widget sortActivity(
      List<Activity> activities, String method, String lat, String long) {
    if (method == "Latest Date") {
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
              key: ObjectKey(context),
              background: swipeLeft(),
              onDismissed: (direction) {
                Boxes.deleteActivity(activities.length - index - 1);
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ActivityDetail(
                              element, activities.length - index - 1)));
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
                                    ' ${element.startTime} - ${element.endTime}',
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
    } else if (method == "Nearby") {
      List<double> distances = [];
      for (var element in activities) {
        var result = GeoLocator.calculateDistance(
            double.parse(lat),
            double.parse(long),
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
                Boxes.deleteActivity(activities.length - index - 1);
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
                                  activities.length - index - 1)));
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
}
