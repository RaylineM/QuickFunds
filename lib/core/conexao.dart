import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class VerificadorConexao {
  Future<bool> get connected;
}

class VerificadorConexaoImpl implements VerificadorConexao {
  final Connectivity _checker;

  VerificadorConexaoImpl(
    this._checker,
  );

  @override
  Future<bool> get connected async {
    final result = await _checker.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
}