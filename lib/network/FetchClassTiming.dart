import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/util/FetchDataException.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchClassTiming extends ClassTimingRepository {
  @override
  Future<List<ClassTiming>> fetchClassTiming() async {
    List<ClassTiming> classTiming = List();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String batch = sharedPreferences.getString(KEY_BATCH);
    String branch = sharedPreferences.getString(KEY_BRANCH);
    String myKey = branch + batch;

    var document =
        Firestore.instance.collection(COLLECTION_ATTENDANCE).document(myKey);

    await document.get().then((doc) {
      doc.data.forEach((key, value) {
        List<String> list = value.toString().split(",");
        classTiming.add(
          ClassTiming(
            paper: key,
            day: list[0],
            startTime: list[1].replaceAll(":", ""),
            endTime: list[2].replaceAll(":", ""),
            lat: list[3],
            lon: list[4],
          ),
        );
      });
    }).catchError((error) => throw FetchDataException(error));

    return classTiming;
  }
}
