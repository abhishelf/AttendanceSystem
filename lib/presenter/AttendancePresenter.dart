import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/util/Injector.dart';

abstract class AttendanceViewContract {
  void onLoadAttendance(List<Attendance> attendance);

  void onLoadException(String error);
}

class AttendancePresenter {
  AttendanceViewContract _viewContract;
  AttendanceRepository _repository;

  AttendancePresenter(this._viewContract) {
    _repository = Injector().attendanceRepository;
  }

  void loadAttendance() {
    _repository
        .fetchAttendance()
        .then((value) => _viewContract.onLoadAttendance(value))
        .catchError((error) => _viewContract.onLoadException(error.toString()));
  }
}
