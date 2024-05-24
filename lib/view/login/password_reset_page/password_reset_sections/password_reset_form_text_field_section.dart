import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/input_form_field/input_field_widged.dart';

class PasswordResetFormTextFieldSection extends StatelessWidget {
  const PasswordResetFormTextFieldSection(
      {super.key,
      required this.title,
      required this.name,
      required this.obscureText,
      required this.textInputType,
      required this.controller});
  final String title;
  final String name;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: CustomeInputField(
        title: title,
        name: name,
        obscureText: obscureText,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Wypełnij pole';
          }
          return null;
        },
        keyboardType: textInputType,
        maxLines: 1,
      ),
    );
  }
}
