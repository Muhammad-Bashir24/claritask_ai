import 'package:claritask_ai/core/network/network_info.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection connection;

  NetworkInfoImpl(this.connection);

  @override
  Future<bool> get isConnected async {
    return connection.hasInternetAccess;
  }
}
