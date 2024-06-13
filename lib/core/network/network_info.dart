import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  NetworkInfo(NetworkInfoImpl Function() param0);
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  const NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
