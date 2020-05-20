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
      url: "images/paper_active.png",type: "All",),
  StudentNotification(
      date: "27/3/2016",
      url: "images/paper_active.png",type: "IT",),
  StudentNotification(
      date: "2/4/2016",
      url: "images/paper_active.png",type: "2K16",),
  StudentNotification(
      date: "6/5/2016",
      url: "images/paper_active.png",type: "IT2K16",),
];
