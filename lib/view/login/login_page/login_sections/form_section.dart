import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/helper/mixins/form_field_validation_helper_mixin.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_text_field_widget.dart';

class LoginFormSection extends StatelessWidget with FormValidationHelper {
  const LoginFormSection({
    super.key,
    required this.formKey,
    required this.saveControllersData,
  });
  final GlobalKey<FormState> formKey;
  final Function(Map<String, dynamic>) saveControllersData;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileEditFormLabel(
              title: "E-mail",
            ),
            ProfileEditFormTextField(
              title: 'Wpisz swój adres email',
              name: 'email',
              controllerValue: '',
              saveControllerData: saveControllersData,
              textInputType: TextInputType.emailAddress,
              validator: simpleValidaion,
              textInputFormatterList: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
            ),
            const ProfileEditFormLabel(
              title: "Hasło",
            ),
            ProfileEditFormTextField(
              title: 'Wpisz hasło',
              name: 'password',
              controllerValue: '',
              saveControllerData: saveControllersData,
              textInputType: TextInputType.visiblePassword,
              validator: simpleValidaion,
              obscureText: true,
              textInputFormatterList: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
