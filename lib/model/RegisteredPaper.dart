class RegisteredPaper {
  String semester;
  List<String> paperName;

  RegisteredPaper({this.semester, this.paperName});

  RegisteredPaper.fromMap(Map<String, dynamic> map) {
    map.forEach((key, value) {
      semester = key;
      paperName = value;
    });
  }
}

abstract class RegisteredPaperRepository {
  Future<List<RegisteredPaper>> fetchRegisteredPaper();
}
