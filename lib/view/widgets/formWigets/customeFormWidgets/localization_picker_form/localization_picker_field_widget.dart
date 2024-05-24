import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class LocalizationPickerField extends StatelessWidget {
  const LocalizationPickerField(
      {super.key, required this.controller, required this.title});
  final TextEditingController controller;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child:
          LabelText(text: controller.text.isNotEmpty ? controller.text : title),
    );
  }
}
