import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
//  Future<bool> get isConnected => connectionChecker.hasConnection;
  // MEMO: 在 firebase 設定好之前, 先固定回傳 false
  Future<bool> get isConnected => Future.value(false);
}
