class Attendance {

  String paperName;
  List<String> presentDate;
  List<String> absentDate;
  int totalClass;
  double percentage;
  
  Attendance({this.paperName, this.presentDate, this.absentDate}){
    totalClass = presentDate.length + absentDate.length;
    percentage = (presentDate.length*100.0)/totalClass;
  }
}

abstract class AttendanceRepository {
  Future<List<Attendance>> fetchAttendance(String batch, String branch);
}