import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {

  final List<StudentNotification> notification;
  final List<Attendance> attendance;
  final List<RegisteredPaper> registeredPaper;

  MainPage({Key key, this.notification, this.attendance, this.registeredPaper}) : super(key:key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
