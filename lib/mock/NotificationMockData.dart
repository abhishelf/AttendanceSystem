import 'package:attendancesystem/model/Notification.dart';

class NotificationMockData extends NotificationRepository {
  @override
  Future<List<Notification>> fetchNotification() {
    return Future.value(_notificationList);
  }
}

var _notificationList = <Notification>[
  Notification(
      date: "22/3/2016",
      text: "Hello this is the demo notification to just test"),
  Notification(
      date: "27/3/2016",
      text: "Hello this is the demo notification to just test"),
  Notification(
      date: "2/4/2016",
      text: "Hello this is the demo notification to just test"),
  Notification(
      date: "6/5/2016",
      text: "Hello this is the demo notification to just test"),
];
