import 'dart:async';

import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:attendancesystem/network/Auth.dart';
import 'package:attendancesystem/presenter/AttendancePresenter.dart';
import 'package:attendancesystem/presenter/ClassTimingPresenter.dart';
import 'package:attendancesystem/presenter/NotificationPresenter.dart';
import 'package:attendancesystem/presenter/RegisteredPaperPresenter.dart';
import 'package:attendancesystem/util/MyNavigator.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    implements
        RegisteredPaperViewContract,
        AttendanceViewContract,
        NotificationViewContract {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double _iconRadius = 64.0;

  RegisteredPaperPresenter _registeredPaperPresenter;
  AttendancePresenter _attendancePresenter;
  NotificationPresenter _notificationPresenter;

  List<StudentNotification> _notification;
  List<Attendance> _attendance;
  List<RegisteredPaper> _registeredPaper;

  bool _isAuthenticated = false;
  bool _isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    _registeredPaperPresenter = RegisteredPaperPresenter(this);
    _attendancePresenter = AttendancePresenter(this);
    _notificationPresenter = NotificationPresenter(this);

    _checkAuth();

    Timer(Duration(seconds: 5), () {
      _isTimerFinished = true;
      if (!_isAuthenticated) {
        MyNavigator.goToLoginPage(context);
      } else {
        if (_notification != null) {
          MyNavigator.goToMainPage(
              context, _notification, _attendance, _registeredPaper);
        }
      }
    });
  }

  _checkAuth() {
    Auth().getCurrentUser().then((user) {
      if (user != null) {
        user?.uid == null ? _isAuthenticated = false : _isAuthenticated = true;

        if (_isAuthenticated) {
          _attendancePresenter.loadAttendance();
        }
      } else {
        _isAuthenticated = false;
      }
    }).catchError((_) {
      _isAuthenticated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: _iconRadius,
                child: Transform.rotate(
                  angle: -50,
                  child: Text(
                    APP_NAME[0],
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 100.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitThreeBounce(
                  color: Colors.white,
                  size: 32.0,
                ),
                Text(
                  APP_NAME,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void onLoadAttendance(List<Attendance> attendance) {
    _attendance = attendance;
    _registeredPaperPresenter.loadRegisteredPaper();
  }

  @override
  void onLoadRegisteredPaper(List<RegisteredPaper> registeredPaper) {
    _registeredPaper = registeredPaper;
    _notificationPresenter.loadNotification();
  }

  @override
  void onLoadNotification(List<StudentNotification> notification) {
    _notification = notification;
    if (_isTimerFinished) {
      MyNavigator.goToMainPage(
          context, _notification, _attendance, _registeredPaper);
    }
  }

  @override
  void onLoadException(String error) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(ERROR_NETWORK),
      action: SnackBarAction(
        label: BUTTON_RETRY,
        onPressed: () {
          if (_attendance == null) {
            _attendancePresenter.loadAttendance();
          } else if (_registeredPaper == null) {
            _registeredPaperPresenter.loadRegisteredPaper();
          } else {
            _notificationPresenter.loadNotification();
          }
          _scaffoldKey.currentState.removeCurrentSnackBar();
        },
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 60),
    ));
  }
}
