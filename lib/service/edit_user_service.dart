import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';

import '../repository/edit_user_repository.dart';

class EditUserService with ChangeNotifier, DiagnosticableTreeMixin {
  EditUserModel? _editUserModel;
  EditUserModel? get editUserModel => _editUserModel;
  set editUserModel(EditUserModel? editUserModel) {
    _editUserModel = editUserModel;
    notifyListeners();
  }

  static const String editUserModelPropName = "editUserModel";

  final _editUserRepository = EditUserRepository();
  Future<Response<dynamic>> saveChanges(EditUserModel editUserModel) async {
    return await _editUserRepository.editUser(editUserModel);
  }

  void getUserProfile() async {
    EditUserModel? model;
    var response = await _editUserRepository.getUser();
    if (response != null) {
      model = EditUserModel.fromJson(response);
    }
    editUserModel = model;
  }

  EditUserModel createEditUserModel(Map<String, String> controllers,
      Map<String, dynamic> imagePathList, List<String> tags,
      [LatLng? latLng]) {
    return EditUserModel(
        firstName: controllers['name']!,
        description: controllers['description']!,
        coordinates:
            Coordinates(x: latLng?.longitude ?? 0, y: latLng?.latitude ?? 0),
        photos: imagePathList,
        tags: tags);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('editUserModel', editUserModel));
  }
}
