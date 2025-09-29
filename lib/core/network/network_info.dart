// lib/core/network/network_info.dart
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // TODO: Implement network connectivity check
    return true; // Assume connected for local-first app
  }
}