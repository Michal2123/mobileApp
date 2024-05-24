import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_data_mixin.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_path_helper_mixin.dart';
import 'package:flutter_mobile_app/interface/cache_interface.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/model/missing_models/missing_dog_detail_model.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class MissingDogRepository
    with CacheData, CachePathHelper
    implements CacheInterface {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  @override
  getAndCacheData(
      {required String url,
      String? category,
      bool? removeCache,
      Map<String, dynamic>? queryParam}) async {
    if (removeCache ?? false) {
      removeAllCacheInCategory(category ?? '');
    }
    var data = await getCacheData(cacheFilePathCreator(url, queryParam));
    if (data == null) {
      await _dioClient.refreshToken().then((_) async {
        await _dioClient.api
            .get(
          url,
          queryParameters: queryParam,
        )
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

  Future<List<dynamic>?> getCurrntAds(int page,
      [bool removeCache = false]) async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/missing-dog/current-ads';
    final Map<String, dynamic> queryParam = {'Page': page};
    const String category = '/missing-dog/';
    return await getAndCacheData(
        url: url,
        category: category,
        removeCache: removeCache,
        queryParam: queryParam);
  }

  Future<List<dynamic>?> getUserAds([bool removeCache = false]) async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/missing-dog/user-ads';
    const String category = '/missing-dog/';
    return await getAndCacheData(
        url: url, category: category, removeCache: removeCache);
  }

  Future<dynamic> getDetails(String missingDogId) async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/missing-dog/details';
    final Map<String, dynamic> queryParam = {'MissingDogId': missingDogId};
    return await getAndCacheData(url: url, queryParam: queryParam);
  }

  Future<dynamic> addAd(MissingDogDetailModel missingDogAd) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
        '${config[ConfigFileKeys.apiURL.keyName]}/api/missing-dog/add',
        data: missingDogAd.toJson(),
      );
      await removeAllCacheInCategory('/missing-dog/');
      return response.data;
    });
  }

  Future<dynamic> editAd(MissingDogDetailModel missingDogAd) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
        '${config[ConfigFileKeys.apiURL.keyName]}/api/missing-dog/edit',
        data: missingDogAd.toJson(),
      );
      await removeAllCacheInCategory('/missing-dog/');
      return response.data;
    });
  }

  Future<Response<dynamic>> deleteAd(String missingDogId) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.delete(
        '${config[ConfigFileKeys.apiURL.keyName]}/api/missing-dog',
        queryParameters: {'MissingDogId': missingDogId},
      );
      await removeAllCacheInCategory('/missing-dog/');
      return response;
    });
  }
}
