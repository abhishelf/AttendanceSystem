import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:attendancesystem/network/Auth.dart';
import 'package:attendancesystem/util/MyNavigator.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:attendancesystem/view/AttendanceScreen.dart';
import 'package:attendancesystem/view/DashboardScreen.dart';
import 'package:attendancesystem/view/NotificationScreen.dart';
import 'package:attendancesystem/view/QueryScreen.dart';
import 'package:attendancesystem/view/RegisteredPaperScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainPage extends StatefulWidget {
  final List<StudentNotification> notification;
  final List<Attendance> attendance;
  final List<RegisteredPaper> registeredPaper;

  MainPage({Key key, this.notification, this.attendance, this.registeredPaper})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _screens;
  int _index = 0;

  _redirectToLoginPage() {
    Auth().signOut().then((_) {
      MyNavigator.goToLoginPage(context);
    });
  }

  @override
  void initState() {
    super.initState();

    _screens = [
      DashboardScreen(
        attendance: widget.attendance,
      ),
      RegisteredPaperScreen(
        registeredPaper: widget.registeredPaper,
      ),
      AttendanceScreen(),
      QueryScreen(),
      NotificationScreen(
        notification: widget.notification,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          APP_BAR_TITLE[_index],
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              _showInfo();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              _redirectToLoginPage();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _index = 2;
          });
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.cloud_upload,
          color: _index == 2 ? Colors.yellowAccent : Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 48.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
                icon: Transform.rotate(
                  angle: -0.5,
                  child: Icon(
                    Icons.dashboard,
                    color: _index == 0 ? Colors.yellowAccent : Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
                icon: Transform.rotate(
                  angle: -0.5,
                  child: Image(
                    image: AssetImage("images/paper.png"),
                    color: _index == 1 ? Colors.yellowAccent : Colors.white,
                    height: 26.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 3;
                  });
                },
                icon: Transform.rotate(
                  angle: -0.5,
                  child: Icon(
                    Icons.mail_outline,
                    color: _index == 3 ? Colors.yellowAccent : Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 4;
                  });
                },
                icon: Transform.rotate(
                  angle: -0.5,
                  child: Icon(
                    Icons.notifications_none,
                    color: _index == 4 ? Colors.yellowAccent : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _screens[_index],
    );
  }

  _showInfo() {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(APP_UNDER_DEVELOPMENT),
      backgroundColor: Colors.blueGrey,
      duration: Duration(seconds: 4),
    ));
  }
}
