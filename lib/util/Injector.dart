import 'package:attendancesystem/mock/AttendanceMockData.dart';
import 'package:attendancesystem/mock/ClassTimingMockData.dart';
import 'package:attendancesystem/mock/NotificationMockData.dart';
import 'package:attendancesystem/mock/RegisteredPaperMockData.dart';
import 'package:attendancesystem/model/Attendance.dart';
import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/model/Notification.dart';
import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/network/FetchAttendance.dart';
import 'package:attendancesystem/network/FetchNotification.dart';
import 'package:attendancesystem/network/FetchRegisteredPaper.dart';

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
        return FetchAttendance();
    }
  }

  NotificationRepository get notificationRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return NotificationMockData();
      default:
        return FetchNotification();
    }
  }

  RegisteredPaperRepository get registeredPaperRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return RegisteredPaperMockData();
      default:
        return FetchRegisteredPaper();
    }
  }

  ClassTimingRepository get classTimingRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return ClassTimingMockData();
      default:
        //TODO
        return null;
    }
  }
}
