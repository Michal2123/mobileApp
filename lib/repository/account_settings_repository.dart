import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import '../main.dart';

class AccountSettingsRepository {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  Future<dynamic> passwordReset(String email) async {
    var response = await _dioClient.api.post(
      '${config[ConfigFileKeys.authURL.keyName]}/api/identity/password-reset',
      data: {'email': email},
      options: Options(headers: {'Authorization': null}),
    );
    return response.data;
  }

  Future<dynamic> passwordChange(
      String currentPassword, String newPassword) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
          '${config[ConfigFileKeys.authURL.keyName]}/api/identity/password-change',
          data: {
            'currentPassword': currentPassword,
            'newPassword': newPassword
          });
      return response.data;
    });
  }

  Future<dynamic> emailChange(String email) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
          '${config[ConfigFileKeys.authURL.keyName]}/api/identity/email-change',
          data: {
            'newEmail': email,
          });
      return response.data;
    });
  }
}
