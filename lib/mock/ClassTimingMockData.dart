import 'package:attendancesystem/model/ClassTiming.dart';

class ClassTimingMockData extends ClassTimingRepository {
  @override
  Future<List<ClassTiming>> fetchClassTiming() {
    return Future.value(_timing);
  }
}

var _timing = <ClassTiming>[
  ClassTiming(
      day: "Mon",
      startTime: "1000",
      endTime: "1050",
      lat: "82.33",
      lon: "25.9",
      paper: "OS"),
  ClassTiming(
      day: "Tue",
      startTime: "1000",
      endTime: "1050",
      lat: "82.33",
      lon: "25.9",
      paper: "OS"),
  ClassTiming(
      day: "Wed",
      startTime: "1000",
      endTime: "1050",
      lat: "82.33",
      lon: "25.9",
      paper: "OS"),
  ClassTiming(
      day: "Mon",
      startTime: "1100",
      endTime: "1150",
      lat: "82.33",
      lon: "25.9",
      paper: "DBMS"),
];
