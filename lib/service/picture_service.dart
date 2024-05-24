import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_mobile_app/repository/picture_repository.dart';

class PictureService {
  final _pictureRepository = PictureRepository();
  FormData formData = FormData();
  Future<List<String>> addPictures(List<Map<String, dynamic>> images) async {
    if (images.isNotEmpty) {
      List<MultipartFile> multipartImageList = [];
      for (var item in images) {
        if (!item['value'].toString().contains('http')) {
          var image = await MultipartFile.fromFile(item['value'],
              contentType: MediaType("image", "jpeg"));
          multipartImageList.add(image);
        }
      }
      FormData formData = FormData.fromMap({'photos': multipartImageList});
      return _pictureRepository.uploadPicture(formData);
    }
    return [];
  }

  Future<void> reorderPictures(List<String> photosOrder) async {
    if (photosOrder.isNotEmpty) {
      await _pictureRepository.uploadPictureOrder(photosOrder);
    }
  }

  Future<dynamic> deletePictures(List<String> guids) async {
    var result = await _pictureRepository.deletePicture(guids);
    return result;
  }

  Future<bool> uploadPetPhoto(String dogId, String filePath) async {
    if (filePath.isNotEmpty) {
      var image = await MultipartFile.fromFile(filePath,
          contentType: MediaType("image", "jpeg"));
      formData.files.add(MapEntry('photo', image));
      formData.fields.add(MapEntry('dogId', dogId));
      var responseStatusCode =
          await _pictureRepository.uploadPetPhoto(formData);
      if (responseStatusCode == 200) return true;
    }
    return false;
  }
}
