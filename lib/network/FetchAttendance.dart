import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/util/FetchDataException.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchAttendance extends AttendanceRepository {
  @override
  Future<List<Attendance>> fetchAttendance() async {
    List<Attendance> attendanceList = List();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String batch = sharedPreferences.getString(KEY_BATCH);
    String branch = sharedPreferences.getString(KEY_BRANCH);
    String roll = sharedPreferences.getString(KEY_ROLL);
    String myKey = branch + batch;

    var document =
        Firestore.instance.collection(COLLECTION_ATTENDANCE).document(myKey);
    await document.get().then((doc) {
      attendanceList.add(Attendance.fromMap(doc.data, roll));
    }).catchError((error) => throw FetchDataException(error));

    return attendanceList;
  }
}
