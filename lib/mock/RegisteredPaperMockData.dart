import 'package:attendancesystem/model/RegisteredPaper.dart';

class RegisteredPaperMockData extends RegisteredPaperRepository {
  @override
  Future<List<RegisteredPaper>> fetchRegisteredPaper(
      String batch, String branch) {
    return Future.value(_registeredPaperList);
  }
}

var _registeredPaperList = <RegisteredPaper>[
  RegisteredPaper(paperName: "DBMS", semester: "3"),
  RegisteredPaper(paperName: "Math", semester: "3"),
  RegisteredPaper(paperName: "Biology", semester: "3"),
  RegisteredPaper(paperName: "Java", semester: "3"),
  RegisteredPaper(paperName: "OS", semester: "4"),
  RegisteredPaper(paperName: "Gentic", semester: "5"),
  RegisteredPaper(paperName: "PSC", semester: "6"),
];
