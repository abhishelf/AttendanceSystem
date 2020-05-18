import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:attendancesystem/view/LoginPage.dart';
import 'package:attendancesystem/view/MainPage.dart';
import 'package:flutter/material.dart';

class MyNavigator {
  static void goToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  static void goToMainPage(
      BuildContext context,
      List<StudentNotification> notification,
      List<Attendance> attendance,
      List<RegisteredPaper> registeredPaper) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            attendance: attendance,
            notification: notification,
            registeredPaper: registeredPaper,
          ),
        ));
  }
}
