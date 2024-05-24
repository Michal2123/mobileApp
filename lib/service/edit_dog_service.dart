import 'package:flutter/foundation.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';

import '../repository/edit_dog_repository.dart';
import '../model/edit_profile_models/dog_model.dart';

class EditDogService with ChangeNotifier, DiagnosticableTreeMixin {
  final _dogRepository = EditDogRepository();
  List<GetDogModel> _dogsList = [];
  List<GetDogModel> get dogsList => _dogsList;
  static const String missingDogListPropName = "dogsList";

  GetDogDetailModel? _dogDetailModel;
  GetDogDetailModel? get dogDetailModel => _dogDetailModel;
  set editDogModel(GetDogDetailModel? dogDetailModel) {
    _dogDetailModel = dogDetailModel;
    notifyListeners();
  }

  static const String editDogModelPropName = "editDogModel";

  Future<String?> saveChanges(EditDogModel editDogModel) async {
    String? dogId = editDogModel.dogId;
    if (dogId?.isNotEmpty == true) {
      await _edit(editDogModel);
      return dogId;
    }
    dogId = await _add(editDogModel);
    return dogId;
  }

  Future<void> _edit(EditDogModel editDogModel) async {
    var dogId = editDogModel.dogId;
    if (dogId != null) {
      await _dogRepository.editDog(editDogModel).then((_) {
        var index = _dogsList.indexWhere((dog) => dog.dogId == dogId);
        if (index > -1) {
          _dogsList[index] = GetDogModel(dogId: dogId, name: editDogModel.name);
          notifyListeners();
        }
      });
    }
  }

  Future<String?> _add(EditDogModel editDogModel) async {
    var dogId = await _dogRepository.addDog(editDogModel);
    if (dogId != null) {
      _dogsList.add(GetDogModel(dogId: dogId, name: editDogModel.name));
      notifyListeners();
    }
    return dogId;
  }

  Future<void> get() async {
    var response = await _dogRepository.getDogs();
    if (response != null) {
      _dogsList = GetDogModel.getListFromJson(response);
      notifyListeners();
    }
  }

  Future<void> getDetails(String dogId) async {
    GetDogDetailModel? getDogDetail;
    var response = await _dogRepository.getDogDetails(dogId);
    if (response != null) {
      getDogDetail = GetDogDetailModel.fromJson(response);
    }
    editDogModel = getDogDetail;
  }

  Future<List<GetDogDetailModel>?> getAllDogsDetails() async {
    List<GetDogDetailModel>? getAllDogDetailList;
    var response = await _dogRepository.getAllDogsDetails();
    if (response != null) {
      getAllDogDetailList = GetDogDetailModel.getListFromJson(response);
    }
    return getAllDogDetailList;
  }

  Future<void> deleteDog(String dogId) async {
    await _dogRepository.deleteDogProfile(dogId).then((_) {
      _dogsList.removeWhere((pet) => pet.dogId == dogId);
      notifyListeners();
    });
  }

  SwipeProfileDogModel toSwipeDogModel(GetDogDetailModel dogModel,
      [String? dogId]) {
    return SwipeProfileDogModel(
        id: dogId,
        name: dogModel.name,
        sex: dogModel.sex,
        breed: dogModel.breed,
        age: (DateTime.now()
                    .difference(DateTime.parse(dogModel.dateOfBirth!))
                    .inDays /
                365)
            .round(),
        description: dogModel.description,
        photo: dogModel.photo ?? '');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('dogsList', dogsList));
    properties.add(ObjectFlagProperty('dogDetailModel', dogDetailModel));
  }
}
