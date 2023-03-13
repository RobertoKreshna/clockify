import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 1)
class Activity extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String duration;
  @HiveField(2)
  late String startDate;
  @HiveField(3)
  late String startTime;
  @HiveField(4)
  late String endDate;
  @HiveField(5)
  late String endTime;
  @HiveField(6)
  late String long;
  @HiveField(7)
  late String lat;

  Activity(this.title, this.duration, this.startDate, this.startTime,
      this.endDate, this.endTime, this.long, this.lat);
}
