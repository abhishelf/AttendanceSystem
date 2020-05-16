import 'package:attendancesystem/model/ClassTiming.dart';
import 'package:attendancesystem/util/Injector.dart';

abstract class ClassTimingViewContract {
  void onLoadClassTiming(List<ClassTiming> classTiming);

  void onLoadException(String error);
}

class ClassTimingPresenter {
  ClassTimingViewContract _viewContract;
  ClassTimingRepository _repository;

  ClassTimingPresenter(this._viewContract) {
    _repository = Injector().classTimingRepository;
  }

  void loadClassTiming() {
    _repository
        .fetchClassTiming()
        .then((value) => _viewContract.onLoadClassTiming(value))
        .catchError((error) => _viewContract.onLoadException(error));
  }
}
