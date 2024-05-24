import 'package:flutter/foundation.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/repository/swipe_profile_repository.dart';

class SwipeProfileService with ChangeNotifier, DiagnosticableTreeMixin {
  final _swipeProfileRepository = SwipeProfileRepository();

  final List<SwipeProfileModel> _swipeProfiles = [];
  List<SwipeProfileModel> get swipeProfiles => _swipeProfiles;
  static const String swipeProfilesPropName = "swipeProfiles";

  Future<void> getProfiles(int distance) async {
    if (_swipeProfiles.length < 2) {
      var response = await _swipeProfileRepository.getProfiles(distance);
      if (response != null) {
        var swipeProfileList = SwipeProfileModel.getListFromJson(response);
        if (swipeProfileList.isNotEmpty) {
          for (var profile in swipeProfileList) {
            var isInList = _swipeProfiles
                .any((swipeProfile) => profile.id == swipeProfile.id);
            if (!isInList) {
              _swipeProfiles.insert(0, profile);
            }
          }
          notifyListeners();
        }
      }
    }
  }

  Future<void> deleteProfile() async {
    _swipeProfiles.removeLast();
    notifyListeners();
  }

  Future<bool> acceptProfile(String id) async {
    var response = await _swipeProfileRepository.acceptProfile(id);
    return response;
  }

  SwipeProfileModel createSwipeProfileModel(Map<String, String> controllers,
      List<String> imagePathList, List<String> tags,
      [List<SwipeProfileDogModel>? dogList]) {
    return SwipeProfileModel(
        id: "",
        firstName: controllers['name']!,
        description: controllers['description']!,
        distance: 0,
        dogs: dogList,
        photos: imagePathList,
        tags: tags);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('swipeProfiles', _swipeProfiles));
  }
}
