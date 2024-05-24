import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/helper/mixins/form_field_validation_helper_mixin.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_text_field_widget.dart';

class RegistrationFormSection extends StatelessWidget
    with FormValidationHelper {
  const RegistrationFormSection(
      {super.key, required this.formKey, required this.saveControllersData});
  final GlobalKey<FormState> formKey;
  final Function(Map<String, dynamic>) saveControllersData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: formKey,
        child: Column(
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
              title: "Login",
            ),
            ProfileEditFormTextField(
              title: 'Wpisz swój login',
              name: 'login',
              controllerValue: '',
              saveControllerData: saveControllersData,
              textInputType: TextInputType.name,
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
