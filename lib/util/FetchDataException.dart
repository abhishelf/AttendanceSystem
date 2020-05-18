import 'package:attendancesystem/util/String.dart';

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return ERROR_FETCHING_DATA;
    return _message;
  }
}