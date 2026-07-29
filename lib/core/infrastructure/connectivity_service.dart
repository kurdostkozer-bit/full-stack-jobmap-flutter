/// Connectivity service (abstraction for network status)
abstract class ConnectivityService {
  Future<bool> isConnected();
  Stream<bool> onConnectivityChanged();
}

/// Simple connectivity implementation
class SimpleConnectivityService implements ConnectivityService {
  @override
  Future<bool> isConnected() async {
    // Lightweight default: assume connected. Replace with `connectivity_plus`
    // implementation when adding the dependency.
    return true;
  }

  @override
  Stream<bool> onConnectivityChanged() {
    // Default stream that always emits `true`. Replace with
    // `Connectivity().onConnectivityChanged` mapping when using
    // `connectivity_plus`.
    return Stream<bool>.value(true);
  }
}

/// Production connectivity service (future with connectivity_plus)
class ConnectivityPlusService implements ConnectivityService {
  @override
  Future<bool> isConnected() async {
    // Not implemented - production implementation should use
    // `connectivity_plus` to check platform connectivity.
    return true;
  }

  @override
  Stream<bool> onConnectivityChanged() {
    // Not implemented - production implementation should expose a
    // stream that reflects platform connectivity changes.
    return Stream<bool>.value(true);
  }
}
