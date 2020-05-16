import 'package:attendancesystem/database/DatabaseHelper.dart';
import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FireStoreOperationInterface {
  Future<bool> uploadQuery(String query, String rollNo);

  Future<bool> updateAttendance();
}

class FireStoreOperation implements FireStoreOperationInterface {
  Future<ClassTiming> _getClassName(String day, String time) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    var className = await databaseHelper.getTiming(day, time);
    return className;
  }

  @override
  Future<bool> updateAttendance() async {
    try {
      Map<String, String> map = getCurrentTiming();

      ClassTiming className = await _getClassName(map['day'], map['time']);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String batch = sharedPreferences.getString(KEY_BATCH);
      String branch = sharedPreferences.getString(KEY_BRANCH);
      String rollNo = sharedPreferences.getString(KEY_ROLL);
      String myKey = branch + batch;

      await Firestore.instance
          .collection(COLLECTION_ATTENDANCE)
          .document(myKey)
          .updateData({
            className.paper: {
              map['date']: FieldValue.arrayUnion([rollNo]),
            },
          },
      );
    } catch (error) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> uploadQuery(String query, String rollNo) async {
    String date = getCurrentTiming()['date'];

    try {
      await Firestore.instance.collection(COLLECTION_QUERY).add({
        'query': query,
        'roll': rollNo,
        'date': date,
      });
    } catch (_) {
      return false;
    }

    return true;
  }
}
