import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class CacheImageManager {
  static const key = 'CacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod:
          Duration(days: config[ConfigFileKeys.cacheDurationInDays.keyName]),
      maxNrOfCacheObjects: 75,
    ),
  );
}
