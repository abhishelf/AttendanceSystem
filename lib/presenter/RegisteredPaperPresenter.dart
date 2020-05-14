import 'package:attendancesystem/model/RegisteredPaper.dart';
import 'package:attendancesystem/util/Injector.dart';

abstract class RegisteredPaperViewContract {
  void onLoadRegisteredPaper(List<RegisteredPaper> registeredPaper);

  void onLoadException(String error);
}

class RegisteredPaperPresenter {
  RegisteredPaperViewContract _viewContract;
  RegisteredPaperRepository _repository;

  RegisteredPaperPresenter(this._viewContract) {
    _repository = Injector().registeredPaperRepository;
  }

  void loadRegisteredPaper(String batch, String branch) {
    _repository
        .fetchRegisteredPaper(batch, branch)
        .then((value) => _viewContract.onLoadRegisteredPaper(value))
        .catchError((error) => _viewContract.onLoadException(error.toString()));
  }
}
