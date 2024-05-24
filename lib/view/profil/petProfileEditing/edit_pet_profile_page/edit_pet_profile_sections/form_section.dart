import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/mixins/form_field_validation_helper_mixin.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/dog_model.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_tag_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_text_field_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_date_field_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_gender_picker_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_search_list_field_widget.dart';

class EditPetProfileFormSection extends StatefulWidget {
  const EditPetProfileFormSection(
      {super.key,
      required this.formKey,
      required this.formMainSectionController,
      required this.saveControllerData});
  final GlobalKey<FormState> formKey;
  final FormMainSectionController formMainSectionController;
  final Function(Map<String, String>) saveControllerData;

  @override
  State<EditPetProfileFormSection> createState() =>
      _EditPetProfileFormSectionState();
}

class _EditPetProfileFormSectionState extends State<EditPetProfileFormSection>
    with FormValidationHelper {
  final _maskShortDateFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  final _maskExtendDateFormatter = MaskTextInputFormatter(
      mask: '##/##/#### ##:##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    GetDogDetailModel? dogDetailModel =
        context.watch<EditDogService>().dogDetailModel;
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
            controllerValue: dogDetailModel?.name ?? '',
            validator: simpleValidaion,
            saveControllerData: widget.saveControllerData,
            textInputType: TextInputType.name,
            textInputFormatterList: [
              FilteringTextInputFormatter.deny(RegExp(r'\s'))
            ],
          ),
          const ProfileEditFormLabel(
            title: 'Rasa',
          ),
          ProfileEditFormSearchListField(
            controllerValue: dogDetailModel?.breed,
            formMainSectionController: widget.formMainSectionController,
          ),
          const ProfileEditFormLabel(
            title: 'Data urodzenia',
          ),
          ProfileEditFormDateField(
            controllerValue: dogDetailModel?.dateOfBirth ?? '',
            name: 'date',
            validator: textEditingValidation,
            saveControllerData: widget.saveControllerData,
            inputMastType: 'short',
            textInputFormatterList: [
              _maskShortDateFormatter,
              _maskExtendDateFormatter
            ],
          ),
          const ProfileEditFormLabel(
            title: 'Płeć',
          ),
          ProfileEditFormGenderPicker(
            contorllerValue: dogDetailModel?.sex,
            formMainSectionController: widget.formMainSectionController,
          ),
          const ProfileEditFormLabel(
            title: 'O zwierzaku',
          ),
          ProfileEditFormTextField(
            title: 'Dodaj opis zwierzaka',
            name: 'description',
            controllerValue: dogDetailModel?.description ?? '',
            validator: simpleValidaion,
            saveControllerData: widget.saveControllerData,
            textInputType: TextInputType.multiline,
          ),
          const ProfileEditFormLabel(
            title: 'Tagi',
          ),
          ProfileEditFormTagField(
            formMainSectionController: widget.formMainSectionController,
          ),
        ],
      ),
    );
  }
}
