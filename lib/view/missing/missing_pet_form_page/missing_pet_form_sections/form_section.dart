import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/mixins/form_field_validation_helper_mixin.dart';
import 'package:flutter_mobile_app/helper/mixins/sufix_age_helper_mixin.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_date_field_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_search_list_field_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_text_field_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_gender_picker_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_licalization_field_widget.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class MissingPetFormSection extends StatefulWidget {
  const MissingPetFormSection(
      {super.key,
      required this.formKey,
      required this.formMainSectionController,
      required this.saveControllerData});
  final GlobalKey<FormState> formKey;
  final FormMainSectionController formMainSectionController;
  final Function(Map<String, String>) saveControllerData;

  @override
  State<MissingPetFormSection> createState() => _MissingPetFormSectionState();
}

class _MissingPetFormSectionState extends State<MissingPetFormSection>
    with SufixAgeHelper, FormValidationHelper {
  final _maskShortDateFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  final _maskExtendDateFormatter = MaskTextInputFormatter(
      mask: '##/##/#### ##:##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    var detailModel = context.watch<MissingDogService>().missingPetDetail;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              const ProfileEditFormLabel(
                title: 'Imię',
              ),
              ProfileEditFormTextField(
                title: 'Dodaj imię',
                name: 'name',
                controllerValue: detailModel?.name ??
                    context.read<MissingDogService>().petName ??
                    '',
                validator: simpleValidaion,
                saveControllerData: widget.saveControllerData,
                textInputType: TextInputType.name,
                textInputFormatterList: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
              ),
              const ProfileEditFormLabel(
                title: 'breed',
              ),
              ProfileEditFormSearchListField(
                controllerValue: detailModel?.breed,
                formMainSectionController: widget.formMainSectionController,
              ),
              const ProfileEditFormLabel(
                title: 'Wiek',
              ),
              ProfileEditFormTextField(
                title: 'Dodaj wiek',
                name: 'age',
                controllerValue: ageCheck(detailModel?.age),
                validator: simpleValidaion,
                saveControllerData: widget.saveControllerData,
                textInputType: TextInputType.number,
                textInputFormatterList: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
              ),
              const ProfileEditFormLabel(
                title: 'Płeć',
              ),
              ProfileEditFormGenderPicker(
                contorllerValue: detailModel?.sex,
                formMainSectionController: widget.formMainSectionController,
              ),
              const ProfileEditFormLabel(
                title: 'Miejsce zaginięcia',
              ),
              ProfileEditFormLocalizationfield(
                title: 'Dodaj miejsce zaginięcia zwierzaka',
                validator: textEditingValidation,
                coordinates: detailModel?.coordinates,
              ),
              const ProfileEditFormLabel(
                title: 'Czas zaginięcia',
              ),
              ProfileEditFormDateField(
                controllerValue: detailModel?.missingDate ?? '',
                name: 'missingDate',
                validator: textEditingValidation,
                saveControllerData: widget.saveControllerData,
                inputMastType: 'expand',
                textInputFormatterList: [
                  _maskShortDateFormatter,
                  _maskExtendDateFormatter
                ],
              ),
              const ProfileEditFormLabel(
                title: 'Treść ogłoszenia',
              ),
              ProfileEditFormTextField(
                title: 'Dodaj potrzebne informacje',
                name: 'about',
                controllerValue: detailModel?.description ?? '',
                validator: simpleValidaion,
                saveControllerData: widget.saveControllerData,
                textInputType: TextInputType.multiline,
                textInputFormatterList: const [],
              ),
              const ProfileEditFormLabel(
                title: 'Kontakt',
                sufix: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: LabelText(
                    text: '(opcjonalne)',
                    fontSize: 14,
                  ),
                ),
              ),
              ProfileEditFormTextField(
                title: 'Dodaj swój numer telefonu',
                name: 'contact',
                controllerValue: detailModel?.contactInfo ?? '',
                saveControllerData: widget.saveControllerData,
                textInputType: TextInputType.phone,
                textInputFormatterList: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
              ),
              const ProfileEditFormLabel(
                title: 'Nagroda',
                sufix: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: LabelText(
                    text: '(opcjonalne)',
                    fontSize: 14,
                  ),
                ),
              ),
              ProfileEditFormTextField(
                title: 'Dodaj informacje o nagrodzie',
                name: 'reward',
                controllerValue: detailModel?.reward != null
                    ? detailModel!.reward.toString()
                    : '',
                saveControllerData: widget.saveControllerData,
                textInputType: TextInputType.number,
                textInputFormatterList: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
              ),
            ],
          )),
    );
  }
}
