import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/model/missing_models/missing_dog_detail_model.dart';
import 'package:flutter_mobile_app/model/missing_models/missing_dog_preview_model.dart';
import 'package:flutter_mobile_app/repository/missing_dog_repository.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class MissingDogService with ChangeNotifier, DiagnosticableTreeMixin {
  List<MissingDogPreviewModel> _missingDogList = [];
  List<MissingDogPreviewModel> get missingDogList => _missingDogList;
  static const String missingDogListPropName = "missingDogList";

  List<MissingDogPreviewModel> _myMissingDogList = [];
  List<MissingDogPreviewModel> get myMissingDogList => _myMissingDogList;
  static const String myMissingDogListPropName = "myMissingDogList";

  MissingDogDetailModel? _missingPetDetail;
  MissingDogDetailModel? get missingPetDetail => _missingPetDetail;
  set missingPetDetail(MissingDogDetailModel? missingPetDetail) {
    _missingPetDetail = missingPetDetail;
    notifyListeners();
  }

  static const String missingPetDetailPropName = "missingPetDetail";

  String? _petName;
  String? get petName => _petName;
  set petName(String? petName) {
    _petName = petName;
    notifyListeners();
  }

  static const String showMapPropName = "petName";

  final _missingDogRepository = MissingDogRepository();

  int currentAdsPage = 1;

  void clearData() {
    missingPetDetail = null;
    petName = null;
  }

  void getAllCurrentAds([bool refresh = false]) async {
    currentAdsPage = 1;

    Future.wait([getUserAds(refresh), getCurrentAds(refresh)]);

    notifyListeners();
  }

  Future<void> getUserAds(bool refresh) async {
    var response = await _missingDogRepository.getUserAds(refresh);
    if (response != null) {
      _myMissingDogList = MissingDogPreviewModel.getListFromJson(response);
    }
  }

  Future<void> getCurrentAds(bool refresh) async {
    var response =
        await _missingDogRepository.getCurrntAds(currentAdsPage, refresh);
    if (response != null) {
      _missingDogList = MissingDogPreviewModel.getListFromJson(response);
    }
  }

  Future<void> getMoreAds() async {
    var modulo = _missingDogList.length % 25;
    if (modulo == 0) {
      currentAdsPage++;
      var response = await _missingDogRepository.getCurrntAds(currentAdsPage);

      if (response != null && response.isNotEmpty) {
        _missingDogList
            .addAll(MissingDogPreviewModel.getListFromJson(response));
        notifyListeners();
      }
    }
  }

  Future<void> getCurrentAdDetails(String missingDogId) async {
    var response = await _missingDogRepository.getDetails(missingDogId);
    _missingPetDetail = MissingDogDetailModel.fromJson(response);
    notifyListeners();
  }

  Future<dynamic> saveAdDetails(
      MissingDogDetailModel missingDogDetailModel) async {
    if (missingDogDetailModel.missingDogId?.isNotEmpty == true) {
      return await _missingDogRepository.editAd(missingDogDetailModel);
    }
    return await _missingDogRepository.addAd(missingDogDetailModel);
  }

  Future<dynamic> deleteAd(String missingDogId) async {
    await _missingDogRepository.deleteAd(missingDogId).then((_) {
      _myMissingDogList.removeWhere((element) => element.id == missingDogId);
      _missingDogList.removeWhere((element) => element.id == missingDogId);
      notifyListeners();
    });
  }

  MissingDogDetailModel createMissingDogDetailModel(
      List<String> imagePathList,
      int breedId,
      Gender gender,
      Map<String, String> controllerList,
      LatLng latLng) {
    return MissingDogDetailModel(
      missingDogId: _missingPetDetail?.missingDogId ?? '',
      name: controllerList['name']!,
      breed: breedId,
      age: int.parse(controllerList['age']!.split(' ').first),
      sex: gender,
      coordinates: Coordinates(x: latLng.longitude, y: latLng.latitude),
      missingDate: controllerList['missingDate'] ?? DateTime.now().toString(),
      description: controllerList['about']!,
      contactInfo: controllerList['contact']!,
      reward: controllerList['reward']!.isNotEmpty
          ? int.parse(controllerList['reward']!)
          : null,
      photos: imagePathList.isNotEmpty ? imagePathList : null,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('missingDogList', _missingDogList));
    properties.add(IterableProperty('myMissingDogList', _myMissingDogList));
    properties.add(ObjectFlagProperty('missingPetDetail', missingPetDetail));
    properties.add(ObjectFlagProperty('petName', petName));
  }
}
