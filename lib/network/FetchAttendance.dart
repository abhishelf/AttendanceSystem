import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/util/FetchDataException.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
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
    String rollNo = sharedPreferences.getString(KEY_ROLL);
    String myKey = branch + batch;

    var document =
        Firestore.instance.collection(COLLECTION_ATTENDANCE).document(myKey);
    await document.get().then((doc) {
      List<String> presentDate = List();
      List<String> absentDate = List();
      doc.data.forEach((key, value) {
        value.forEach((date, roll) {
          bool isFound = false;
          for (int i = 0; i < roll.length; i++) {
            if (equalIgnoreCase(rollNo, roll[i])) {
              presentDate.add(date);
              isFound = true;
              break;
            }
          }
          if (!isFound) absentDate.add(date);
        });

        attendanceList.add(
          Attendance(
            paperName: key,
            presentDate: presentDate,
            absentDate: absentDate,
          ),
        );
      });
    }).catchError((error) => throw FetchDataException(error.toString()));

    return attendanceList;
  }
}
