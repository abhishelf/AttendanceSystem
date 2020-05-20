import 'package:attendancesystem/model/RegisteredPaper.dart';

class RegisteredPaperMockData extends RegisteredPaperRepository {
  @override
  Future<List<RegisteredPaper>> fetchRegisteredPaper() {
    return Future.value(_registeredPaperList);
  }
}

var _registeredPaperList = <RegisteredPaper>[
  RegisteredPaper(semester: "Third", paperName: ["Math", "Biology", "Java", "OS", "Data Structure"],marks: ["A ","A+","B ","C ","Ex"]),
  RegisteredPaper(semester: "Fourth", paperName: ["Economics"],marks: ["Ex"]),
  RegisteredPaper(semester: "Fifth", paperName: ["DBMS"],marks: ["A+"]),
  RegisteredPaper(semester: "Sixth", paperName: ["PSC"],marks: ["A "])
];
