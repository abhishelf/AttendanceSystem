import 'package:attendancesystem/model/Notification.dart';
import 'package:attendancesystem/util/FetchDataException.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchNotification extends NotificationRepository {
  @override
  Future<List<Notification>> fetchNotification() async {
    List<Notification> notificationList = List();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String batch = sharedPreferences.getString(KEY_BATCH);
    String branch = sharedPreferences.getString(KEY_BRANCH);
    String myKey = branch + batch;

    await Firestore.instance
        .collection(COLLECTION_NOTIFICATION)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      try {
        snapshot.documents.forEach((item) {
          String notificationId = item.documentID.split("#")[0];
          if (equalIgnoreCase(notificationId, "all") ||
              equalIgnoreCase(notificationId, batch) ||
              equalIgnoreCase(notificationId, branch) ||
              equalIgnoreCase(notificationId, myKey)) {
            notificationList.add(Notification(
                date: item.data[DB_NOTIFICATION_DATE],
                text: item.data[DB_NOTIFICATION_TEXT]));
          }
        });
      } catch (error) {
        throw FetchDataException(error);
      }
    }).catchError((error) => throw FetchDataException(error));

    return notificationList;
  }
}
