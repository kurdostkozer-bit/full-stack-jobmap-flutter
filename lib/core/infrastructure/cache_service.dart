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
  // NOTE: Lightweight local implementation that mimics a Hive box using
  // a static in-memory map. This avoids adding a Hive dependency while
  // keeping the `CacheService` API usable. Replace with real Hive
  // implementation when `hive` is added to `pubspec.yaml`.
  static final Map<String, String> _box = {};

  @override
  Future<void> set(String key, String value) async {
    _box[key] = value;
  }

  @override
  Future<String?> get(String key) async {
    return _box[key];
  }

  @override
  Future<void> remove(String key) async {
    _box.remove(key);
  }

  @override
  Future<void> clear() async {
    _box.clear();
  }

  @override
  Future<bool> hasKey(String key) async {
    return _box.containsKey(key);
  }
}
