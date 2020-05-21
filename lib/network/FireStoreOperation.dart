import 'package:attendancesystem/database/DatabaseHelper.dart';
import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/util/GlobalFunction.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FireStoreOperationInterface {
  Future<bool> uploadQuery(String related, String query, String additional);

  Future<bool> updateAttendance(ClassTiming className, String date);

  Future<bool> fetchAndSaveProfile(String email);
}

class FireStoreOperation implements FireStoreOperationInterface {

  @override
  Future<bool> updateAttendance(ClassTiming className, String date) async {
    try {
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
              date: FieldValue.arrayUnion([rollNo]),
            },
          },
      );
    } catch (error) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> uploadQuery(String related, String query, String additional) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rollNo = prefs.getString(DB_STUDENT_ROLL);

    String date = getCurrentTiming()['date'];


    try {
      await Firestore.instance.collection(COLLECTION_QUERY).add({
        'query': query,
        'roll': rollNo,
        'date': date,
        'related': related,
        'additional': additional,
      });
    } catch (_) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> fetchAndSaveProfile(String email) async{
    var document =  Firestore.instance.collection(COLLECTION_STUDENT).document(email);
    bool isError = false;
    await document.get().then((doc) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(KEY_ROLL, doc[DB_STUDENT_ROLL]);
      prefs.setString(KEY_BRANCH, doc[DB_STUDENT_BRANCH]);
      prefs.setString(KEY_NAME, doc[DB_STUDENT_NAME]);
      List<String> temp = doc[DB_STUDENT_ROLL].toString().split("/");
      prefs.setString(KEY_BATCH, "2K"+temp[temp.length-1]);
    }).catchError((_){
      isError = true;
    });

    return !isError;
  }
}
