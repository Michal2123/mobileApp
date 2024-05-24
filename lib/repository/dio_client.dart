import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/error_handling.dart';
import 'package:flutter_mobile_app/model/token_model.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/widgets/popups/contextless_popups.dart';
import '../main.dart';
import '../helper/mixins/token_data_mixin.dart';

class DioClient with TokenData {
  final Dio api = Dio();
  final _kiwi = KiwiContainer();
  final storage = KiwiContainer().resolve<FlutterSecureStorage>();
  late TokenModel _tokenModel;
  late String? _token;

  Future<String> getAccessToken() async {
    return (await storage.read(key: StorageKeys.token.name))!;
  }

  Future<void> refreshToken() async {
    _token = await storage.read(key: StorageKeys.token.name);
    bool hasExpired = JwtDecoder.isExpired(_token ?? '');
    if (hasExpired) {
      final refreshToken =
          await storage.read(key: StorageKeys.refreshToken.name);
      await api.post(
          '${config[ConfigFileKeys.authURL.keyName]}/api/identity/refresh-token',
          data: {
            'token': _token,
            'refreshToken': refreshToken
          }).then((response) {
        _tokenModel = TokenModel.fromJson(response.data);
        _token = _tokenModel.token;
        saveToken(_tokenModel, storage);
      }).onError((error, stackTrace) {
        _token = null;
        storage.deleteAll();
      });
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  DioClient() {
    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        _token = await storage.read(key: StorageKeys.token.name);
        options.headers['Authorization'] = 'Bearer $_token';
        options.connectTimeout = Duration(seconds: config['connectonTimeOut']);
        options.receiveTimeout = Duration(seconds: config['connectonTimeOut']);
        if (options.contentType == null) {
          final dynamic data = options.data;
          final String? contentType;
          switch (data) {
            case FormData _:
              contentType = Headers.multipartFormDataContentType;
              break;
            case Map _:
              contentType = Headers.formUrlEncodedContentType;
              break;
            case String _:
              contentType = Headers.jsonContentType;
              break;
            case null:
              contentType = null;
              break;
            default:
              contentType = Headers.textPlainContentType;
          }
          options.contentType = contentType;
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        final errorMessage =
            _kiwi<ExceptionHandler>().fromDioError(error).toString();
        switch (errorMessage) {
          case 'Unauthorized':
            await refreshToken();
            return handler.resolve(await _retry(error.requestOptions));
          case 'Bad request':
            if (error.response != null) {
              var data = error.response?.data as Map;
              if (data['token'] == null && data['refreshToken'] == null) {
                _token = null;
                storage.deleteAll();
                ContextlessPopups().singoutPopup();
              }
            }
            break;
          default:
        }
        handler.next(error);
      },
    ));
  }
}
