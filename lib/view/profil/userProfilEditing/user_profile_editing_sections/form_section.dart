import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/mixins/form_field_validation_helper_mixin.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/service/edit_user_service.dart';
import 'package:flutter_mobile_app/service/map_service.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_licalization_field_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_tag_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_text_field_widget.dart';

class EditUserProfileFormSection extends StatefulWidget {
  const EditUserProfileFormSection(
      {super.key,
      required this.formKey,
      required this.saveControllerData,
      required this.formMainSectionController});
  final GlobalKey<FormState> formKey;
  final Function(Map<String, String>) saveControllerData;
  final FormMainSectionController formMainSectionController;

  @override
  State<EditUserProfileFormSection> createState() =>
      _EditUserProfileFormSectionState();
}

class _EditUserProfileFormSectionState extends State<EditUserProfileFormSection>
    with FormValidationHelper {
  EditUserModel? _editUserModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapService>().latLng = LatLng(
          _editUserModel?.coordinates.y ?? 0,
          _editUserModel?.coordinates.x ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    _editUserModel = context.watch<EditUserService>().editUserModel;
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          const ProfileEditFormLabel(
            title: 'Imię',
          ),
          ProfileEditFormTextField(
            title: 'Dodaj imię',
            name: 'name',
            controllerValue: _editUserModel?.firstName ?? '',
            validator: simpleValidaion,
            saveControllerData: widget.saveControllerData,
            textInputType: TextInputType.name,
            textInputFormatterList: [
              FilteringTextInputFormatter.deny(RegExp(r'\s'))
            ],
          ),
          const ProfileEditFormLabel(
            title: 'O mnie',
          ),
          ProfileEditFormTextField(
            title: 'Dodaj opis swojego profilu',
            name: 'description',
            controllerValue: _editUserModel?.description ?? '',
            validator: simpleValidaion,
            saveControllerData: widget.saveControllerData,
            textInputType: TextInputType.multiline,
            textInputFormatterList: const [],
          ),
          const ProfileEditFormLabel(
            title: 'Lokalizacja',
          ),
          ProfileEditFormLocalizationfield(
            title: 'Dodaj swoją lokalizację',
            validator: textEditingValidation,
            coordinates: _editUserModel?.coordinates,
          ),
          const ProfileEditFormLabel(
            title: 'Tagi',
          ),
          ProfileEditFormTagField(
            formMainSectionController: widget.formMainSectionController,
            userTags: _editUserModel?.tags,
          ),
        ],
      ),
    );
  }
}
