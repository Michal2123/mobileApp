import 'dart:async';

import 'package:flutter_mobile_app/helper/mixins/token_data_mixin.dart';

import '../repository/login_repository.dart';

class LoginService with TokenData {
  final _loginRepository = LoginRepository();
  Future<dynamic> login(String email, String password) async {
    return _loginRepository.signIn(email, password);
  }
}
