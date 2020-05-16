import 'package:attendancesystem/util/String.dart';

class ClassTiming {
  String day;
  String startTime;
  String endTime;
  String lat;
  String lon;
  String paper;

  ClassTiming(
      {this.day, this.startTime, this.endTime, this.lat, this.lon, this.paper});

  ClassTiming.fromMap(Map<String, dynamic> map) {
    paper = map[COL_PAPER];
    day = map[COL_DAY];
    startTime = map[COL_START_TIME];
    endTime = map[COL_END_TIME];
    lat = map[COL_LAT];
    lon = map[COL_LON];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[COL_PAPER] = paper;
    map[COL_DAY] = day;
    map[COL_START_TIME] = startTime;
    map[COL_END_TIME] = endTime;
    map[COL_LAT] = lat;
    map[COL_LON] = lon;

    return map;
  }
}

abstract class ClassTimingRepository {
  Future<List<ClassTiming>> fetchClassTiming();
}
