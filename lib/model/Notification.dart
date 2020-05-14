class Notification {

  String date;
  String text;

  Notification({this.date, this.text});
}

abstract class NotificationRepository {
  Future<List<Notification>> fetchNotification(String batch, String branch);
}