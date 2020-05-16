import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/util/FetchDataException.dart';
import 'package:attendancesystem/util/String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchRegisteredPaper extends RegisteredPaperRepository {
  @override
  Future<List<RegisteredPaper>> fetchRegisteredPaper() async {
    List<RegisteredPaper> registeredPaper = List();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String batch = sharedPreferences.getString(KEY_BATCH);
    String branch = sharedPreferences.getString(KEY_BRANCH);
    String myKey = branch + batch;

    var document = Firestore.instance
        .collection(COLLECTION_REGISTERED_PAPER)
        .document(myKey);

    await document.get().then((doc) {
      try {
        doc.data.forEach((key, value) {
          registeredPaper.add(RegisteredPaper(semester: key, paperName: value));
        });
      } catch (error) {
        throw FetchDataException(error);
      }
    }).catchError((error) => throw FetchDataException(error));

    return registeredPaper;
  }
}
