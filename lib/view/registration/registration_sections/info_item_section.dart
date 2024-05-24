import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class RegistrationInfoItemSection extends StatelessWidget {
  const RegistrationInfoItemSection({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InputLabelText(
        text: text,
        maxLines: 999,
        align: TextAlign.center,
      ),
    );
  }
}
