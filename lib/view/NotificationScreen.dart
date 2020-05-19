import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {

  final List<StudentNotification> notification;
  NotificationScreen({Key key,this.notification}) : super(key:key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("NotificationScreen")),
    );
  }
}
