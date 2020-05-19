import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:flutter/material.dart';

class RegisteredPaperScreen extends StatefulWidget {

  final List<RegisteredPaper> registeredPaper;
  RegisteredPaperScreen({Key key, this.registeredPaper}) : super(key:key);

  @override
  _RegisteredPaperScreenState createState() => _RegisteredPaperScreenState();
}

class _RegisteredPaperScreenState extends State<RegisteredPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("RegisteredPaperScreen")),
    );
  }
}
