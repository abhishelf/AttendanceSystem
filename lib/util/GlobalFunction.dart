import 'package:attendancesystem/util/String.dart';

bool equalIgnoreCase(String str1, String str2) {
  return str1.toLowerCase() == str2.toLowerCase();
}

Map<String, String> getCurrentTiming() {
  Map<String, String> map = new Map();

  var now = DateTime.now();
  String yyyy = now.year.toString();
  String mm = now.month.toString();
  String dd = now.day.toString();
  String weekDay = DAY[now.weekday - 1];
  String time =
      now.toString().split(" ")[1].substring(0, 5).replaceAll(":", "");

  map['date'] = mm + "/" + dd + "/" + yyyy;
  map['time'] = time;
  map['day'] = weekDay;

  return map;
}
