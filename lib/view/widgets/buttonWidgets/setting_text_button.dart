import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class SettingTextButton extends StatelessWidget {
  const SettingTextButton(
      {super.key, required this.onTap, required this.labelText, this.padding});
  final Function()? onTap;
  final String labelText;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(top: 50.0),
        child: GestureDetector(
            onTap: onTap, child: InputLabelText(text: labelText)),
      ),
    );
  }
}
