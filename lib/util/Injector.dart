import 'package:attendancesystem/mock/AttendanceMockData.dart';
import 'package:attendancesystem/mock/NotificationMockData.dart';
import 'package:attendancesystem/mock/RegisteredPaperMockData.dart';
import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/model/Notification.dart';
import 'package:attendancesystem/model/RegisteredPaper.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _injector = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  static Flavor getFlavor() {
    return _flavor;
  }

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  AttendanceRepository get attendanceRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return AttendanceMockData();
      default:
        return null;
      //TODO
    }
  }

  NotificationRepository get notificationRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return NotificationMockData();
      default:
        return null;
      //TODO
    }
  }

  RegisteredPaperRepository get registeredPaperRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return RegisteredPaperMockData();
      default:
        return null;
      //TODO
    }
  }
}
