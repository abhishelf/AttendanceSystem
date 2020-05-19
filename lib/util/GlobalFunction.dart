import 'package:attendancesystem/util/String.dart';
import 'package:flutter/material.dart';

List<Color> listColor = [
  Colors.lightBlue,
  Colors.blueGrey,
  Colors.brown,
  Colors.grey,
  Colors.purple,
];

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

int sortComparator(String a, String b){
  List<String> i1 = a.split("/");
  List<String> i2 = b.split("/");

  if(i1[2] == i2[2]){
    if(i1[1] == i2[1]){
      return i1[0].compareTo(i2[0]);
    }else{
      return i1[1].compareTo(i2[1]);
    }
  }else{
    return i1[2].compareTo(i2[2]);
  }
}
