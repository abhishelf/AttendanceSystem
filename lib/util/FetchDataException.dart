class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Error During Loading Data From Firebase";
    return _message;
  }
}