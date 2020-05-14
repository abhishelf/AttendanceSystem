import 'package:attendancesystem/model/Notification.dart';
import 'package:attendancesystem/util/Injector.dart';

abstract class NotificationViewContract {
  void onLoadNotification(List<Notification> notification);

  void onLoadException(String error);
}

class NotificationPresenter {
  NotificationViewContract _viewContract;
  NotificationRepository _repository;

  NotificationPresenter(this._viewContract) {
    _repository = Injector().notificationRepository;
  }

  void loadNotification(String batch, String branch) {
    _repository
        .fetchNotification(batch, branch)
        .then((value) => _viewContract.onLoadNotification(value))
        .catchError((error) => _viewContract.onLoadException(error.toString()));
  }
}
