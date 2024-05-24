abstract class CacheInterface {
  dynamic getAndCacheData({
    required String url,
    String? category,
    bool? removeCache,
    Map<String, dynamic>? queryParam,
  });
}
