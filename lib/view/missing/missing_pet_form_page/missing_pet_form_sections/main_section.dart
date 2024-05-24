import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/missing_models/missing_dog_detail_model.dart';
import 'package:flutter_mobile_app/service/map_service.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_page.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/form_section.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_gallery_widget.dart';

import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_page.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_upper_section_widget.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/popups/submit_popup.dart';

class FormMainSectionController {
  late Function() loading;
  late Gender Function() getGender;
  late int Function() getBreedId;
  late Function() getMissingDate;
  late Map<String, dynamic> Function() getImageMap;
  late List<String> Function() getTags;
}

class MissingPetFormMainSection extends StatefulWidget {
  const MissingPetFormMainSection({super.key});

  @override
  State<MissingPetFormMainSection> createState() =>
      _MissingPetFormMainSectionState();
}

class _MissingPetFormMainSectionState extends State<MissingPetFormMainSection> {
  final Map<String, String> _controllers = {};
  final _formKey = GlobalKey<FormState>();
  final _formMainSectionController = FormMainSectionController();
  final ContextPopups _contextPopups = ContextPopups();

  MissingDogDetailModel fillModel() {
    List<String> imagePathList =
        List<String>.from(_formMainSectionController.getImageMap().values);
    int breedId = _formMainSectionController.getBreedId();
    Gender gender = _formMainSectionController.getGender();
    LatLng latLng = context.read<MapService>().latLng ?? const LatLng(0, 0);
    MissingDogDetailModel model = context
        .read<MissingDogService>()
        .createMissingDogDetailModel(
            imagePathList, breedId, gender, _controllers, latLng);
    return model;
  }

  void saveControllerData(Map<String, String> data) {
    _controllers.addEntries(data.entries);
  }

  void onPreview() {
    if (formValidationCheck()) {
      context.read<MissingDogService>().missingPetDetail = fillModel();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MissingPetDetail()));
    }
  }

  void onSubmit() {
    if (formValidationCheck()) {
      _contextPopups.loadingIndicator(context);
      MissingDogDetailModel missingDogDetailModel = fillModel();
      context
          .read<MissingDogService>()
          .saveAdDetails(missingDogDetailModel)
          .then((result) {
        Navigator.pop(context);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const SubmitPopup();
            });
        Future.delayed(const Duration(seconds: 2)).then((_) =>
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MissingPets())));
      }).onError((error, stackTrace) {
        Navigator.pop(context);
      });
    }
  }

  bool formValidationCheck() {
    FocusManager.instance.primaryFocus!.unfocus();
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(children: [
          ProfileEditFormUpperSection(
            onPreview: onPreview,
            onSubmit: onSubmit,
          ),
          ProfileEditFormGallery(
            formMainSectionController: _formMainSectionController,
          ),
          MissingPetFormSection(
            formKey: _formKey,
            formMainSectionController: _formMainSectionController,
            saveControllerData: saveControllerData,
          ),
        ]));
  }
}
