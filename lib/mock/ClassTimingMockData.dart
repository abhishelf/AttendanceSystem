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
      startTime: "10:00",
      endTime: "10:50",
      lat: "82.33",
      lon: "25.9",
      paper: "OS"),
  ClassTiming(
      day: "Tue",
      startTime: "10:00",
      endTime: "10:50",
      lat: "82.33",
      lon: "25.9",
      paper: "OS"),
  ClassTiming(
      day: "Wed",
      startTime: "10:00",
      endTime: "10:50",
      lat: "82.33",
      lon: "25.9",
      paper: "OS"),
  ClassTiming(
      day: "Mon",
      startTime: "10:00",
      endTime: "11:50",
      lat: "82.33",
      lon: "25.9",
      paper: "DBMS"),
];
