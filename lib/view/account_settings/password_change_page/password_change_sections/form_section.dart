import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/helper/mixins/form_field_validation_helper_mixin.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_label_widget.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/profileEditFormWidgets/edit_form_text_field_widget.dart';

class PasswordChangeFormSection extends StatelessWidget
    with FormValidationHelper {
  const PasswordChangeFormSection({
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const ProfileEditFormLabel(
              title: "Hasło",
            ),
            ProfileEditFormTextField(
              title: 'Wpisz hasło',
              name: 'password',
              controllerValue: '',
              saveControllerData: saveControllersData,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
              validator: simpleValidaion,
              textInputFormatterList: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
            ),
            const ProfileEditFormLabel(
              title: "Nowe hasło",
            ),
            ProfileEditFormTextField(
              title: 'Wpisz nowe hasło',
              name: 'newPassword',
              controllerValue: '',
              saveControllerData: saveControllersData,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
              validator: simpleValidaion,
              textInputFormatterList: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
            ),
            const ProfileEditFormLabel(
              title: "Powtórz hasło",
            ),
            ProfileEditFormTextField(
              title: 'Powtórz nowe hasło',
              name: 'repeatNewPassword',
              controllerValue: '',
              saveControllerData: saveControllersData,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
              validator: simpleValidaion,
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
