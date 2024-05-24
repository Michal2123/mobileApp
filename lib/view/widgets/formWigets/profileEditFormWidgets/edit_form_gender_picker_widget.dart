import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/gender_picker_widget.dart';

class ProfileEditFormGenderPicker extends StatefulWidget {
  const ProfileEditFormGenderPicker(
      {super.key,
      required this.formMainSectionController,
      this.contorllerValue});
  final FormMainSectionController formMainSectionController;
  final Gender? contorllerValue;

  @override
  State<ProfileEditFormGenderPicker> createState() =>
      _MissingPetFromGenderPickerSectionState();
}

class _MissingPetFromGenderPickerSectionState
    extends State<ProfileEditFormGenderPicker> {
  Gender _gender = Gender.male;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.formMainSectionController.getGender = getGenderValue;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gender = widget.contorllerValue ?? Gender.male;
  }

  Gender getGenderValue() {
    return _gender;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GenderPicker(
        gender: _gender,
        genderPicker: (pickedGender) {
          FocusManager.instance.primaryFocus!.unfocus();
          setState(() {
            _gender = pickedGender;
          });
        },
      ),
    );
  }
}
