import 'package:attendancesystem/model/RegisteredPaper.dart';

class RegisteredPaperMockData extends RegisteredPaperRepository {
  @override
  Future<List<RegisteredPaper>> fetchRegisteredPaper() {
    return Future.value(_registeredPaperList);
  }
}

var _registeredPaperList = <RegisteredPaper>[
  RegisteredPaper(semester: "3", paperName: ["Math", "Biology", "Java", "OS"]),
  RegisteredPaper(semester: "4", paperName: ["Economics"]),
  RegisteredPaper(semester: "5", paperName: ["DBMS"]),
  RegisteredPaper(semester: "6", paperName: ["PSC"])
];
