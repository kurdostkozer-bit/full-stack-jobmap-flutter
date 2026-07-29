/// Local cache service (abstraction for future implementations)
abstract class CacheService {
  Future<void> set(String key, String value);
  Future<String?> get(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> hasKey(String key);
}

/// In-memory cache implementation (simple)
class MemoryCacheService implements CacheService {
  final Map<String, String> _cache = {};

  @override
  Future<void> set(String key, String value) async {
    _cache[key] = value;
  }

  @override
  Future<String?> get(String key) async {
    return _cache[key];
  }

  @override
  Future<void> remove(String key) async {
    _cache.remove(key);
  }

  @override
  Future<void> clear() async {
    _cache.clear();
  }

  @override
  Future<bool> hasKey(String key) async {
    return _cache.containsKey(key);
  }
}

/// HiveCache implementation (future)
class HiveCacheService implements CacheService {
  @override
  Future<void> set(String key, String value) async {
    // TODO: Implement Hive storage
    throw UnimplementedError();
  }

  @override
  Future<String?> get(String key) async {
    // TODO: Implement Hive retrieval
    throw UnimplementedError();
  }

  @override
  Future<void> remove(String key) async {
    // TODO: Implement Hive removal
    throw UnimplementedError();
  }

  @override
  Future<void> clear() async {
    // TODO: Implement Hive clear
    throw UnimplementedError();
  }

  @override
  Future<bool> hasKey(String key) async {
    // TODO: Implement Hive key check
    throw UnimplementedError();
  }
}
