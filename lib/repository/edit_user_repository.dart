import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_data_mixin.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_path_helper_mixin.dart';
import 'package:flutter_mobile_app/interface/cache_interface.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import '../main.dart';
import '../model/edit_profile_models/edit_user_model.dart';

class EditUserRepository
    with CacheData, CachePathHelper
    implements CacheInterface {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  @override
  getAndCacheData(
      {required String url,
      String? category,
      bool? removeCache,
      Map<String, dynamic>? queryParam}) async {
    var data = await getCacheData(cacheFilePathCreator(url));
    if (data == null) {
      await _dioClient.refreshToken().then((_) async {
        await _dioClient.api.get(url).then((response) {
          data = response.data;
          saveCacheData(
              data,
              cacheFilePathCreator(url),
              Duration(
                  hours: config[ConfigFileKeys.cacheDurationInHour.keyName]));
          return data;
        });
      });
    }
    return data;
  }

  Future<Response<dynamic>> editUser(EditUserModel editUserModel) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/user/edit',
          data: editUserModel.toJson());
      await removeAllCacheInCategory('/user');
      return response;
    });
  }

  Future<dynamic> getUser() async {
    final String url = '${config[ConfigFileKeys.apiURL.keyName]}/api/user';
    return await getAndCacheData(url: url);
  }
}
