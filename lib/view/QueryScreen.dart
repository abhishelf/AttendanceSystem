import 'package:attendancesystem/network/FireStoreOperation.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QueryScreen extends StatefulWidget {
  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  static TextEditingController _query = TextEditingController();
  static TextEditingController _relatedTo = TextEditingController();
  static TextEditingController _additional = TextEditingController();

  List<Step> _step;

  bool _isLoading = false;

  int _currentIndex = 0;

  next() {
    if (_currentIndex == 0) {
      if (_relatedTo.text.isNotEmpty) {
        goTo(_currentIndex + 1);
      }
    } else if (_currentIndex == 1) {
      if (_query.text.isNotEmpty) {
        goTo(_currentIndex + 1);
      }
    } else if (_currentIndex == 2) {
      setState(() {
        _isLoading = true;
        _submitQuery();
      });
    }
  }

  cancel() {
    if (_currentIndex > 0) goTo(_currentIndex - 1);
  }

  goTo(int step) {
    setState(() => _currentIndex = step);
  }

  _clearText(){
    _relatedTo.clear();
    _query.clear();
    _additional.clear();
  }

  _submitQuery() {
    FireStoreOperation()
        .uploadQuery(_relatedTo.text, _query.text, _additional.text)
        .then((flag) {
          if(flag){
            _clearText();
          }
      flag ? _showToast(HINT_SUBMITTED) : _showToast(ERROR);
    }).catchError((_) {
      _showToast(ERROR);
    });
  }

  @override
  void initState() {
    super.initState();
    _step = [
      Step(
        title: Text(STEP1_TITLE),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 48.0, top: 16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: HINT_RELATED,
                    ),
                    keyboardType: TextInputType.text,
                    controller: _relatedTo,
                    enabled: !_isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Step(
        title: Text(STEP2_TITLE),
        state: StepState.indexed,
        isActive: true,
        content: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 48.0, top: 16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: HINT_QUERY,
                    ),
                    keyboardType: TextInputType.text,
                    controller: _query,
                    maxLines: 5,
                    enabled: !_isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Step(
        title: Text(STEP3_TITLE),
        state: StepState.indexed,
        isActive: true,
        content: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 48.0, top: 16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: HINT_ADDITIONAL,
                    ),
                    keyboardType: TextInputType.text,
                    controller: _additional,
                    enabled: !_isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        steps: _step,
        currentStep: _currentIndex,
        onStepContinue: next,
        onStepCancel: cancel,
        physics: ClampingScrollPhysics(),
        onStepTapped: (step) {
          if (step < _currentIndex) goTo(step);
        },
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            children: <Widget>[
              MaterialButton(
                onPressed: _isLoading ? null : onStepContinue,
                color:
                    _isLoading ? Colors.grey : Theme.of(context).primaryColor,
                child: _isLoading
                    ? SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor,
                        size: 22.0,
                      )
                    : _currentIndex != 2
                        ? Text(
                            BUTTON_CONTINUE,
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            BUTTON_SUBMIT,
                            style: TextStyle(color: Colors.white),
                          ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
              ),
              _currentIndex == 0 || _isLoading
                  ? Container()
                  : MaterialButton(
                      onPressed: onStepCancel,
                      color: Colors.white,
                      child: Text(BUTTON_CANCEL),
                    ),
            ],
          );
        },
      ),
    );
  }

  _showToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
    );

    setState(() {
      _isLoading = false;
    });
  }
}
