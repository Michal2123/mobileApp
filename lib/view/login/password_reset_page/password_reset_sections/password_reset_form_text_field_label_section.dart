import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class PasswordResetFormTextFieldLabelSection extends StatelessWidget {
  const PasswordResetFormTextFieldLabelSection(
      {super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 66, right: 18),
      child: InputLabelText(
        text: title,
      ),
    );
  }
}
