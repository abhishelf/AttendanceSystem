import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardScreen extends StatefulWidget {
  final List<Attendance> attendance;

  DashboardScreen({Key key, this.attendance}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Attendance> _list;

  @override
  void initState() {
    super.initState();
    _list = widget.attendance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.only(right: 8, bottom: 48),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          List<String> totalClass = List.from(_list[index].presentDate);
          totalClass.addAll(_list[index].absentDate);

          totalClass.sort((a, b) => sortComparator(a, b));

          int presentIndex = 0;
          return ExpansionTile(
            initiallyExpanded: index == 0 ? true : false,
            leading: CircleAvatar(
              backgroundColor: listColor[index % listColor.length],
              child: Center(
                child: Text(
                  _list[index].paperName[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            title: Text(
              _list[index].paperName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _list[index].presentDate.length.toString() +
                        " / " +
                        _list[index].totalClass.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    _list[index].percentage.toStringAsFixed(2) + " %",
                    style: TextStyle(
                      color: _list[index].percentage >= 75
                          ? Colors.teal
                          : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                reverse: true,
                crossAxisSpacing: 40.0,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 6),
                crossAxisCount: 2,
                children: List.generate(_list[index].totalClass, (indexG) {
                  if (presentIndex < _list[index].presentDate.length &&
                      totalClass[indexG] ==
                          _list[index].presentDate[presentIndex]) {
                    presentIndex++;
                    return Center(
                      child: Text(
                        totalClass[indexG],
                        style: TextStyle(color: Colors.green),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        totalClass[indexG],
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
