import 'package:attendancesystem/database/DatabaseHelper.dart';
import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/network/FireStoreOperation.dart';
import 'package:attendancesystem/util/LocalAuthenticationService.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final LocalAuthenticationService _auth = LocalAuthenticationService();
  DatabaseHelper _databaseHelper;

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String _message = HINT_PRESS_TO_AUTH;

  _askForLocationPermission() async {
    var flag = await LocationPermissions().checkPermissionStatus();
    if (flag != PermissionStatus.granted)
      await LocationPermissions().requestPermissions();
  }

  _authenticateStudent() async {
    setState(() {
      _isLoading = true;
      _message = HINT_AUTHENTICATING;
    });
    _isAuthenticated = await _auth.authenticateStudent();
    if (_isAuthenticated) {
      _fetchCurrentClassName();
    }else{
      setState(() {
        _isLoading = false;
      });
    }
  }

  _fetchCurrentClassName() async {
    setState(() {
      _isLoading = true;
      _message = HINT_GETTING_SUBJECT;
    });

    Map<String, String> map = getCurrentTiming();
    ClassTiming className =
        await _databaseHelper.getTiming(map['day'], map['time']);
    if (className == null) {
      _message = ERROR_NOT_ANY_CLASS;
      setState(() {
        _isLoading = false;
      });
    } else {
      _checkLastUpdated(className, map['date']);
    }
  }

  _checkLastUpdated(ClassTiming classTiming, String date) async {
    setState(() {
      _isLoading = true;
      _message = HINT_CHECKING_ATTENDANCE;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String updatedTiming = sharedPreferences.getString(KEY_LAST_UPDATE);

    if (equalIgnoreCase(updatedTiming, classTiming.paper + date)) {
      _message = ERROR_ATTENDANCE_ALREADY_UPDATE;
      setState(() {
        _isLoading = false;
      });
    } else {
      _getCurrentLocation(classTiming, date);
    }
  }

  _getCurrentLocation(ClassTiming classTiming, String date) async {
    setState(() {
      _isLoading = true;
      _message = HINT_CHECKING_CLASSROOM;
    });

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position != null)
      _updateAttendance(classTiming, date);
    else {
      _message = ERROR_NOT_IN_CLASSROOM;
      setState(() {
        _isLoading = false;
      });
    }
  }

  _updateAttendance(ClassTiming classTiming, String date) async {
    setState(() {
      _isLoading = true;
      _message = HINT_UPDATING_ATTENDANCE;
    });

    var flag = await FireStoreOperation().updateAttendance(classTiming, date);
    if (flag) {
      _message = HINT_UPDATED_ATTENDANCE;

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(KEY_LAST_UPDATE, classTiming.paper + date);
    } else {
      _message = ERROR_FAILED_TO_UPDATE;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _askForLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitCircle(
                  color: Theme.of(context).primaryColor,
                ),
                Text(_message,style: TextStyle(color: Theme.of(context).primaryColor,),),
              ],
            )
          : Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: _authenticateStudent,
                    child: Icon(
                      Icons.fingerprint,
                      color: Colors.blue,
                      size: 64.0,
                    ),
                  ),
                  Text(
                    _message,
                    style: TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
