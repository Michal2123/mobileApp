import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

import '../model/sign_models/loign_model.dart';
import '../model/token_model.dart';
import 'dart:async';

class LoginRepository {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  Future<Response<dynamic>> signIn(String email, String password) async {
    return _dioClient.api
        .post('${config[ConfigFileKeys.authURL.keyName]}/api/identity/sign-in',
            data: LoginModel(email: email, password: password).toJson(),
            options: Options(headers: {'Authorization': null}))
        .then((response) {
      _dioClient.saveToken(
          TokenModel.fromJson(response.data), _dioClient.storage);
      return response;
    });
  }
}
