class RegisteredPaper {

  String semester;
  String paperName;

  RegisteredPaper({this.semester, this.paperName});
}

abstract class RegisteredPaperRepository {
  Future<List<RegisteredPaper>> fetchRegisteredPaper(String batch, String branch);
}