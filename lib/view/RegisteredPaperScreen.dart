import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RegisteredPaperScreen extends StatefulWidget {
  final List<RegisteredPaper> registeredPaper;

  RegisteredPaperScreen({Key key, this.registeredPaper}) : super(key: key);

  @override
  _RegisteredPaperScreenState createState() => _RegisteredPaperScreenState();
}

class _RegisteredPaperScreenState extends State<RegisteredPaperScreen> {
  List<RegisteredPaper> _list;

  @override
  void initState() {
    super.initState();
    _list = widget.registeredPaper;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8.0, bottom: 48.0),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(22.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: getRandomColor(index),
                    width: 6.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: index == 0 ? true : false,
                  title: Text(
                    _list[index].semester,
                    style: TextStyle(
                      color: getRandomColor(index),
                      fontSize: 18.0,
                    ),
                  ),
                  children: <Widget>[
                    ListView.builder(
                      padding: EdgeInsets.only(left: 22.0, bottom: 16.0),
                      shrinkWrap: true,
                      itemCount: _list[index].paperName.length,
                      itemBuilder: (context, indexL) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _list[index].paperName[indexL],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              width: 64.0,
                              child: Text(
                                _list[index].marks[indexL],
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
