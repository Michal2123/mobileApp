import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/dog_model.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/service/edit_user_service.dart';
import 'package:flutter_mobile_app/service/picture_service.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/edit_pet_profile_page/edit_pet_profile_sections/form_section.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/pet_profile_list_page/pet_profile_list_page.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_page.dart';
import 'package:flutter_mobile_app/view/widgets/detailPageWidgets/profile_image.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_upper_section_widget.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/popups/submit_popup.dart';

import '../../../../../utils/enums.dart';

class EditPetProfileMainSection extends StatefulWidget {
  const EditPetProfileMainSection(
      {super.key,
      required this.formMainSectionController,
      required this.dogId});
  final FormMainSectionController formMainSectionController;
  final String? dogId;

  @override
  State<EditPetProfileMainSection> createState() =>
      _EditPetProfileMainSectionState();
}

class _EditPetProfileMainSectionState extends State<EditPetProfileMainSection> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  Gender _gender = Gender.male;
  int _breed = 0;
  final Map<String, String> _controllers = {};

  final PictureService _pictureService = PictureService();
  final ContextPopups _contextPopups = ContextPopups();

  void getControllersData() {
    _gender = widget.formMainSectionController.getGender();
    _breed = widget.formMainSectionController.getBreedId();
  }

  SwipeProfileModel? detailProfileDataFill() {
    EditUserModel? editUserModel =
        context.read<EditUserService>().editUserModel;
    var petProfile = createSwipePetModel();
    if (editUserModel != null) {
      return SwipeProfileModel(
        id: '',
        firstName: editUserModel.firstName,
        description: editUserModel.description,
        photos: editUserModel.photos?.entries
            .map((e) => e.value as String)
            .toList(),
        distance: 0,
        dogs: [petProfile],
        tags: editUserModel.tags,
      );
    }
    return null;
  }

  SwipeProfileDogModel createSwipePetModel() {
    var dogDetails = GetDogDetailModel(
        name: _controllers['name']!,
        breed: _breed,
        dateOfBirth: _controllers['date']!,
        description: _controllers['description']!,
        sex: _gender,
        photo: _imagePath);
    return context.read<EditDogService>().toSwipeDogModel(dogDetails);
  }

  getImageGallery() async {
    try {
      var imageFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 95);
      if (imageFile == null) return;
      setState(() {
        _imagePath = imageFile.path;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Filed to pick image: $e');
      }
    }
  }

  EditDogModel fillEditDogModel() {
    EditDogModel model = EditDogModel(
        dogId: widget.dogId,
        name: _controllers['name']!,
        dateOfBirth: _controllers['date']!,
        sex: _gender,
        breed: _breed,
        description: _controllers['description']!);

    return model;
  }

  void imagePathCheck(String? dogId) async {
    if (_imagePath != null &&
        _imagePath?.contains('http') == true &&
        dogId != null) {
      await _pictureService.uploadPetPhoto(dogId, _imagePath!);
    }
  }

  void saveControllerData(Map<String, String> data) {
    _controllers.addEntries(data.entries);
  }

  void onPreview() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      getControllersData();
      var details = detailProfileDataFill();
      if (details != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailProfile(swipeProfileModel: details)));
      }
    }
  }

  void onSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      getControllersData();
      var model = fillEditDogModel();
      _contextPopups.loadingIndicator(context);
      context.read<EditDogService>().saveChanges(model).then((dogId) {
        imagePathCheck(dogId);
        Navigator.pop(context);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const SubmitPopup();
            });
        Future.delayed(const Duration(seconds: 2)).then((_) {
          context.read<EditDogService>().get();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PetProfileList()));
        });
      }).onError((error, stackTrace) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          ProfileEditFormUpperSection(
            onSubmit: onSubmit,
            onPreview: onPreview,
          ),
          GestureDetector(
            onTap: () {
              getImageGallery();
            },
            child: ProfileImage(
              imagePath: _imagePath,
            ),
          ),
          EditPetProfileFormSection(
            formKey: _formKey,
            formMainSectionController: widget.formMainSectionController,
            saveControllerData: saveControllerData,
          )
        ]);
  }
}
