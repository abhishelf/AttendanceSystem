import 'dart:math';

class RegisteredPaper {
  String semester;
  List<String> paperName;
  List<String> marks;

  //FIXME update in network
  RegisteredPaper({this.semester, this.paperName,this.marks}){
    if(marks == null)
      marks = List.generate(paperName.length,(_) => "");
  }

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
