import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class LocalAuthenticationService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticateStudent() async {
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    return authenticated;
  }

  void _cancelAuthentication() {
    _auth.stopAuthentication();
  }
}
