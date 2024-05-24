import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_data_mixin.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_path_helper_mixin.dart';
import 'package:flutter_mobile_app/interface/cache_interface.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class ExercisesRepository
    with CacheData, CachePathHelper
    implements CacheInterface {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  @override
  getAndCacheData(
      {required String url,
      String? category,
      bool? removeCache,
      Map<String, dynamic>? queryParam}) async {
    var data = await getCacheData(cacheFilePathCreator(url, queryParam));
    if (data == null) {
      await _dioClient.refreshToken().then((_) async {
        await _dioClient.api
            .get(url, queryParameters: queryParam)
            .then((response) {
          data = response.data;
          saveCacheData(
              data,
              cacheFilePathCreator(url, queryParam),
              Duration(
                  hours: config[ConfigFileKeys.cacheDurationInHour.keyName]));
          return data;
        });
      });
    }
    return data;
  }

  Future<List<dynamic>> getExercises() async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/exercise/get-all';
    return await getAndCacheData(url: url);
  }

  Future<dynamic> getDetails(String exerciseId) async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/exercise/get-exercise-details';
    final Map<String, dynamic> queryParam = {'Id': exerciseId};
    return await getAndCacheData(url: url, queryParam: queryParam);
  }
}
