import 'package:attendancesystem/util/Injector.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:attendancesystem/view/SplashPage.dart';
import 'package:flutter/material.dart';

void main() {
  Injector.configure(Flavor.MOCK);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        hintColor: Colors.grey,
        buttonColor: Colors.blue,
        cardColor: Colors.white,
        dividerColor: Colors.black12,
        disabledColor: Colors.grey,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 26.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16.0,
          ),
        ),
      ),
      home: SplashPage(),
    );
  }
}
