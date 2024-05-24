import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/helper/mixins/form_field_validation_helper_mixin.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_text_field_widget.dart';

class EmailChangeFormSection extends StatelessWidget with FormValidationHelper {
  const EmailChangeFormSection(
      {super.key, required this.saveControllerData, required this.formKey});
  final Function(Map<String, dynamic>) saveControllerData;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 66),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const ProfileEditFormLabel(
                title: "E-mail",
              ),
              ProfileEditFormTextField(
                  title: 'Wpisz swój adres email',
                  name: 'email',
                  controllerValue: '',
                  saveControllerData: saveControllerData,
                  textInputType: TextInputType.emailAddress,
                  textInputFormatterList: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s'))
                  ],
                  validator: simpleValidaion)
            ],
          ),
        ),
      ),
    );
  }
}
