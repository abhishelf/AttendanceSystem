import 'package:attendancesystem/database/DatabaseHelper.dart';
import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:attendancesystem/network/Auth.dart';
import 'package:attendancesystem/network/FireStoreOperation.dart';
import 'package:attendancesystem/presenter/AttendancePresenter.dart';
import 'package:attendancesystem/presenter/ClassTimingPresenter.dart';
import 'package:attendancesystem/presenter/NotificationPresenter.dart';
import 'package:attendancesystem/presenter/RegisteredPaperPresenter.dart';
import 'package:attendancesystem/util/MyNavigator.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements ClassTimingViewContract,RegisteredPaperViewContract,
    AttendanceViewContract,
    NotificationViewContract {

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DatabaseHelper _databaseHelper;

  ClassTimingPresenter _presenter;
  RegisteredPaperPresenter _registeredPaperPresenter;
  AttendancePresenter _attendancePresenter;
  NotificationPresenter _notificationPresenter;

  List<StudentNotification> _notification;
  List<Attendance> _attendance;
  List<RegisteredPaper> _registeredPaper;

  bool _isObscure = true;
  bool _isLoading = false;

  String _validateEmail(String email) {
    if (!EmailValidator.validate(email)) {
      return ERROR_EMAIL;
    }

    return null;
  }

  String _validatePassword(String password) {
    if (password.length < 6) {
      return ERROR_PASSWORD;
    }

    return null;
  }

  void _submitForm(context) {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      Auth()
          .signIn(_emailController.text, _passwordController.text)
          .then((_userId) {
        if (_userId != null) {
          _presenter.loadClassTiming();
        } else {
          _showError();
        }
      }).catchError((_) {
        _showError();
      });
    }
  }

  void _showError(){
    setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(
      msg: ERROR_LOGIN_FAILED,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
    );
  }

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();

    _presenter = ClassTimingPresenter(this);
    _registeredPaperPresenter = RegisteredPaperPresenter(this);
    _attendancePresenter = AttendancePresenter(this);
    _notificationPresenter = NotificationPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.fromLTRB(22.0, 48.0, 22.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              TITLE_LOGIN,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 48.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
            ),
            Text(
              SUBTITLE_LOGIN,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
              ),
            ),
            Expanded(
              flex: 1,
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(bottom: 48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: HINT_EMAIL,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        enabled: !_isLoading,
                        validator: (value) {
                          return _validateEmail(value);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                            labelText: HINT_PASSWORD,
                            suffixIcon: GestureDetector(
                              child: !_isObscure
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onTap: () {
                                setState(() {
                                  _isObscure
                                      ? _isObscure = false
                                      : _isObscure = true;
                                });
                              },
                            )),
                        keyboardType: TextInputType.visiblePassword,
                        enabled: !_isLoading,
                        obscureText: _isObscure,
                        controller: _passwordController,
                        validator: (value) {
                          return _validatePassword(value);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48.0),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            if (_isLoading) return null;
                            return _submitForm(context);
                          },
                          color: _isLoading
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: _isLoading
                              ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: SpinKitThreeBounce(
                                    color: Theme.of(context).primaryColor,
                                    size: 22.0,
                                  ))
                              : Text(BUTTON_LOGIN),
                          height: 48.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: DO_NOT_HAVE_ACCOUNT,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: CONTACT_YOUR_COLLEGE,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0, left: 64.0, right: 64.0),
              child: Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onLoadClassTiming(List<ClassTiming> classTiming) {
    _databaseHelper.insertTiming(classTiming).then((_){
      FireStoreOperation().fetchAndSaveProfile(_emailController.text).then((isError){
        if(isError){
          Auth().signOut();
          _showError();
        }else{
          _attendancePresenter.loadAttendance();
        }
      }).catchError((_){
        Auth().signOut();
        _showError();
      });
    }).catchError((_){
      Auth().signOut();
      _showError();
    });
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

    //TODO REMOVE
    print("hello Moto");
    print(_attendance.length);
    print(_registeredPaper.length);
    print(_notification.length);

    MyNavigator.goToMainPage(
        context, _notification, _attendance, _registeredPaper);
  }

  @override
  void onLoadException(String error) {
    Auth().signOut();
    _showError();
  }
}
