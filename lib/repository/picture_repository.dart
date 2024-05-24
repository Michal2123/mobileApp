import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import '../main.dart';

class PictureRepository {
  final _dioClient = KiwiContainer().resolve<DioClient>();
  Future<List<String>> uploadPicture(FormData photosFormData) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/user/add-photos',
          data: photosFormData);
      return List<String>.from(response.data as List);
    });
  }

  Future<void> uploadPictureOrder(List<String> photosOrder) async {
    _dioClient.refreshToken().then((_) async {
      await _dioClient.api.post(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/user/reorder-photos',
          data: <String, dynamic>{'photos': photosOrder});
    });
  }

  Future<dynamic> deletePicture(List<String> guids) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.delete(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/user/delete-photos',
          data: <String, dynamic>{'photosNames': guids});
      return response.data;
    });
  }

  Future<int?> uploadPetPhoto(FormData photo) async {
    return _dioClient.refreshToken().then((_) async {
      final response = await _dioClient.api.post(
          '${config[ConfigFileKeys.apiURL.keyName]}/api/dog/update-photo',
          data: photo);
      return response.statusCode;
    });
  }
}
