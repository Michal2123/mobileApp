mixin CachePathHelper {
  String cacheFilePathCreator(url, [Map? queryParam]) {
    if (queryParam != null) {
      return '$url?${queryParam.entries.first.key}=${queryParam.entries.first.value}';
    }
    return url;
  }
}
