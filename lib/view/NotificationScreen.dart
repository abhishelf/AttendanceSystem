import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
import 'package:attendancesystem/util/Injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationScreen extends StatefulWidget {

  final List<StudentNotification> notification;
  NotificationScreen({Key key,this.notification}) : super(key:key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<StudentNotification> _list;

  @override
  void initState() {
    super.initState();
    _list = widget.notification;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        padding: EdgeInsets.only(top: 16.0,bottom: 48.0,left: 16.0,right: 16.0,),
        mainAxisSpacing: 28.0,
        crossAxisSpacing: 22.0,
        childAspectRatio: 1.1,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(_list.length, (index){
          return Container(
            decoration: BoxDecoration(
              border: Border.all( color: listColor[index%listColor.length],width: 0.4),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image(
                  image:  Injector.getFlavor() == Flavor.MOCK ? AssetImage(_list[index].url):NetworkImage(_list[index].url),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loading){
                    if(loading == null) return child;
                    return Center(
                      child: SpinKitCircle(
                        color: listColor[index%listColor.length],
                        size: 22.0,
                      )
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: double.infinity,
                      padding: EdgeInsets.only(right: 8.0,bottom: 4.0),
                      color: listColor[index%listColor.length].withOpacity(0.5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                            _list[index].date,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
