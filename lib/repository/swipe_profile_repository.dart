import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class SwipeProfileRepository {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  Future<dynamic> getProfiles(int distance) async {
    return _dioClient.refreshToken().then((_) async {
      var response = await _dioClient.api.post(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/swipe/get-users',
          data: {'distance': distance, 'quantity': 2});
      return response.data;
    });
  }

  Future<dynamic> acceptProfile(String id) async {
    return _dioClient.refreshToken().then((_) async {
      var response = await _dioClient.api.post(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/swipe/accept',
          data: {'id': id});
      return response.data;
    });
  }
}
