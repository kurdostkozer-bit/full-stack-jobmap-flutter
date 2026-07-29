/// Offline service (queue requests when offline)
abstract class OfflineService {
  Future<void> queueRequest(String endpoint, Map<String, dynamic> data);
  Future<List<QueuedRequest>> getPendingRequests();
  Future<void> clearQueue();
  Future<void> syncQueue();
}

class QueuedRequest {
  final String endpoint;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  QueuedRequest({
    required this.endpoint,
    required this.data,
    required this.timestamp,
  });
}

/// Simple offline queue implementation
class SimpleOfflineService implements OfflineService {
  final List<QueuedRequest> _queue = [];

  @override
  Future<void> queueRequest(String endpoint, Map<String, dynamic> data) async {
    _queue.add(
      QueuedRequest(
        endpoint: endpoint,
        data: data,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<List<QueuedRequest>> getPendingRequests() async {
    return _queue;
  }

  @override
  Future<void> clearQueue() async {
    _queue.clear();
  }

  @override
  Future<void> syncQueue() async {
    // TODO: Sync queued requests when online
  }
}
