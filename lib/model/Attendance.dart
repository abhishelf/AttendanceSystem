import 'package:attendancesystem/util/GlobalFunction.dart';

class Attendance {
  String paperName;
  List<String> presentDate;
  List<String> absentDate;
  int totalClass;
  double percentage;

  Attendance({this.paperName, this.presentDate, this.absentDate}) {
    totalClass = presentDate.length + absentDate.length;
    percentage = (presentDate.length * 100.0) / totalClass;
  }

  Attendance.fromMap(Map<String, dynamic> map, String studentRoll) {
    map.forEach((key, value) {
      paperName = key;
      value.forEach((date, roll) {
        bool isFound = false;
        for (int i = 0; i < roll.length; i++) {
          if (equalIgnoreCase(studentRoll, roll[i])) {
            presentDate.add(date);
            isFound = true;
            break;
          }
        }
        if (!isFound) absentDate.add(date);
      });
    });
    totalClass = presentDate.length + absentDate.length;
    percentage = (presentDate.length * 100.0) / totalClass;
  }
}

abstract class AttendanceRepository {
  Future<List<Attendance>> fetchAttendance();
}
