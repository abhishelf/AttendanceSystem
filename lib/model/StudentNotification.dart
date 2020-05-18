class StudentNotification {

  String date;
  String text;

  StudentNotification({this.date, this.text});
}

abstract class NotificationRepository {
  Future<List<StudentNotification>> fetchNotification();
}