import 'package:attendancesystem/model/StudentNotification.dart';
import 'package:attendancesystem/util/Injector.dart';

abstract class NotificationViewContract {
  void onLoadNotification(List<StudentNotification> notification);

  void onLoadException(String error);
}

class NotificationPresenter {
  NotificationViewContract _viewContract;
  NotificationRepository _repository;

  NotificationPresenter(this._viewContract) {
    _repository = Injector().notificationRepository;
  }

  void loadNotification() {
    _repository
        .fetchNotification()
        .then((value) => _viewContract.onLoadNotification(value))
        .catchError((error) => _viewContract.onLoadException(error.toString()));
  }
}
