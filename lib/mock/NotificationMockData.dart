import 'package:attendancesystem/model/StudentNotification.dart';

class NotificationMockData extends NotificationRepository {
  @override
  Future<List<StudentNotification>> fetchNotification() {
    return Future.value(_notificationList);
  }
}

var _notificationList = <StudentNotification>[
  StudentNotification(
      date: "22/3/2016",
      text: "Hello this is the demo notification to just test"),
  StudentNotification(
      date: "27/3/2016",
      text: "Hello this is the demo notification to just test"),
  StudentNotification(
      date: "2/4/2016",
      text: "Hello this is the demo notification to just test"),
  StudentNotification(
      date: "6/5/2016",
      text: "Hello this is the demo notification to just test"),
];
