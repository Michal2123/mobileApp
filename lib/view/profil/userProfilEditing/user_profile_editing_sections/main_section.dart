import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/service/edit_user_service.dart';
import 'package:flutter_mobile_app/service/map_service.dart';
import 'package:flutter_mobile_app/service/swipe_profile_service.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/profil/profile_page/profile_page.dart';
import 'package:flutter_mobile_app/view/profil/userProfilEditing/user_profile_editing_sections/form_section.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_page.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_gallery_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_upper_section_widget.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/popups/submit_popup.dart';

class EditUserMainSection extends StatefulWidget {
  const EditUserMainSection({
    super.key,
    required this.formMainSectionController,
  });
  final FormMainSectionController formMainSectionController;

  @override
  State<EditUserMainSection> createState() => _EditUserMainSectionState();
}

class _EditUserMainSectionState extends State<EditUserMainSection> {
  final ContextPopups _contextPopups = ContextPopups();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _controllers = {};
  List<String> _tags = [];
  List<String> _imagePathList = [];
  Map<String, dynamic> _imageMap = {};
  LatLng? _latLng;

  void saveControllerData(Map<String, String> data) {
    _controllers.addEntries(data.entries);
  }

  void getFormData() {
    _latLng = context.read<MapService>().latLng;
    _imageMap = widget.formMainSectionController.getImageMap();
    _imagePathList = List<String>.from(_imageMap.values);
    _tags = widget.formMainSectionController.getTags();
  }

  Future<SwipeProfileModel> fillSwipeModel() async {
    getFormData();
    return await context
        .read<EditDogService>()
        .getAllDogsDetails()
        .then((dogsDetails) {
      List<SwipeProfileDogModel>? dogList = dogsDetails
          ?.map((e) => context.read<EditDogService>().toSwipeDogModel(e))
          .toList();
      SwipeProfileModel model = context
          .read<SwipeProfileService>()
          .createSwipeProfileModel(
              _controllers, _imagePathList, _tags, dogList);
      return model;
    });
  }

  EditUserModel fillUserModel() {
    getFormData();
    EditUserModel model = context
        .read<EditUserService>()
        .createEditUserModel(_controllers, _imageMap, _tags, _latLng);
    return model;
  }

  void onPreview() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _contextPopups.loadingIndicator(context);
      fillSwipeModel().then((model) {
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailProfile(swipeProfileModel: model)));
      });
    }
  }

  void onSubmit() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      EditUserModel userModel = fillUserModel();
      _contextPopups.loadingIndicator(context);
      context.read<EditUserService>().saveChanges(userModel).then((_) {
        Navigator.pop(context);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const SubmitPopup();
            });
        Future.delayed(const Duration(seconds: 2)).then((value) =>
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Profile())));
      }).onError((error, stackTrace) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
        children: [
          ProfileEditFormUpperSection(
            onPreview: onPreview,
            onSubmit: onSubmit,
          ),
          const ProfileEditFormLabel(
            title: 'Zdjęcia',
          ),
          ProfileEditFormGallery(
            formMainSectionController: widget.formMainSectionController,
          ),
          EditUserProfileFormSection(
            formKey: _formKey,
            saveControllerData: saveControllerData,
            formMainSectionController: widget.formMainSectionController,
          ),
        ]);
  }
}
