import 'package:attendancesystem/model/Attendance.dart';

class AttendanceMockData extends AttendanceRepository {
  @override
  Future<List<Attendance>> fetchAttendance(String batch, String branch) {
    return Future.value(_attendanceList);
  }
}

var _attendanceList = <Attendance>[
  Attendance(paperName: "Biology", absentDate: [
    "15/3/2016",
    "16/3/2016",
    "17/3/2016"
  ], presentDate: [
    "12/3/2016",
    "13/3/2016",
    "14/3/2016",
    "18/3/2016",
    "19/3/2016",
    "22/3/2016"
  ]),
  Attendance(paperName: "Operating System", absentDate: [
    "15/3/2016",
    "16/3/2016",
    "17/3/2016",
    "20/3/2016",
    "21/3/2016",
    "23/3/2016"
  ], presentDate: [
    "12/3/2016",
    "13/3/2016",
    "14/3/2016",
    "18/3/2016",
    "19/3/2016",
    "22/3/2016"
  ]),
  Attendance(paperName: "DBMS", absentDate: [
    "15/3/2016",
    "16/3/2016",
    "17/3/2016",
    "20/3/2016",
    "21/3/2016",
    "23/3/2016"
  ], presentDate: [
    "12/3/2016",
    "13/3/2016",
    "14/3/2016",
    "18/3/2016",
  ]),
  Attendance(paperName: "Java", absentDate: [
    "15/3/2016",
    "16/3/2016",
    "17/3/2016",
    "20/3/2016",
    "21/3/2016",
    "23/3/2016"
  ], presentDate: [
    "12/3/2016",
    "13/3/2016",
    "14/3/2016",
    "18/3/2016",
    "19/3/2016",
    "22/3/2016"
  ]),
];
