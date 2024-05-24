import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_data_mixin.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_path_helper_mixin.dart';
import 'package:flutter_mobile_app/interface/cache_interface.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import '../main.dart';
import '../model/edit_profile_models/dog_model.dart';

class EditDogRepository
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
            .get(
          url,
          queryParameters: queryParam,
        )
            .then((response) {
          data = response.data;
          saveCacheData(
              response.data,
              cacheFilePathCreator(url, queryParam),
              Duration(
                  hours: config[ConfigFileKeys.cacheDurationInHour.keyName]));
          return data;
        });
      });
    }
    return data;
  }

  Future<String?> addDog(EditDogModel editDogModel) async {
    await _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/dog/add',
          data: editDogModel.toJson());
      await removeAllCacheInCategory('/dog/');
      return response.data;
    });
    return null;
  }

  Future<void> editDog(EditDogModel editDogModel) async {
    await _dioClient.refreshToken().then((_) {
      _dioClient.api
          .post('${config[ConfigFileKeys.apiURL.keyName]}/api/dog/edit',
              data: editDogModel.toJson())
          .then((_) => removeAllCacheInCategory('/dog/'));
    });
  }

  Future<dynamic> getDogs() async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/dog/user-dogs';
    return await getAndCacheData(url: url);
  }

  Future<dynamic> getAllDogsDetails() async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/dog/user-dogs-details';
    return await getAndCacheData(url: url);
  }

  Future<dynamic> getDogDetails(String dogId) async {
    final String url =
        '${config[ConfigFileKeys.apiURL.keyName]}/api/dog/details';
    final Map<String, dynamic> queryParam = {'DogId': dogId};
    return await getAndCacheData(url: url, queryParam: queryParam);
  }

  Future<dynamic> deleteDogProfile(String dogId) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.delete(
        '${config[ConfigFileKeys.apiURL.keyName]}/api/dog',
        data: {'DogId': dogId},
      );
      await removeAllCacheInCategory('/dog/');
      return response.data;
    });
  }
}
