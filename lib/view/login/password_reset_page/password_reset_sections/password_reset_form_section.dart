import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/login/password_reset_page/password_reset_sections/password_reset_form_text_field_label_section.dart';
import 'package:flutter_mobile_app/view/login/password_reset_page/password_reset_sections/password_reset_form_text_field_section.dart';

class PasswordResetFormSection extends StatelessWidget {
  const PasswordResetFormSection(
      {super.key, required this.formKey, required this.emailController});
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            const PasswordResetFormTextFieldLabelSection(
              title: "E-mail",
            ),
            PasswordResetFormTextFieldSection(
              title: 'Wpisz swój adres email',
              name: 'email',
              obscureText: false,
              textInputType: TextInputType.emailAddress,
              controller: emailController,
            ),
          ],
        ));
  }
}
