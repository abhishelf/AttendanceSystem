class StudentNotification {

  String date;
  String url;
  String type;

  StudentNotification({this.date, this.url, this.type});
}

abstract class NotificationRepository {
  Future<List<StudentNotification>> fetchNotification();
}