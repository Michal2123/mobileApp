import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/model/sign_models/registration_model.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import '../main.dart';
import 'dart:async';

class RegistrationRepository {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  Future<Response<dynamic>> register(
      String email, String password, String username) async {
    return _dioClient.api.post(
        '${config[ConfigFileKeys.authURL.keyName]}/api/identity/register',
        options: Options(headers: {'Authorization': null}),
        data: RegistrationModel(
                email: email, password: password, username: username)
            .toJson());
  }
}
