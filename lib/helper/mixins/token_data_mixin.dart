import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_mobile_app/model/token_model.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

mixin TokenData {
  void saveToken(TokenModel tokenModel, FlutterSecureStorage storage) async {
    storage.write(key: StorageKeys.token.name, value: tokenModel.token);
    storage.write(
        key: StorageKeys.refreshToken.name, value: tokenModel.refreshToken);
    var data = JwtDecoder.tryDecode(tokenModel.token);
    storage.write(key: StorageKeys.userId.name, value: data!['userId']);
  }
}
