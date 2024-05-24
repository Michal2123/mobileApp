import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/inkwell_text_widget.dart';

class ProfileEditFormButton extends StatelessWidget {
  const ProfileEditFormButton(
      {super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: onTap,
        child: InkWellText(text: title, weight: FontWeight.w600),
      ),
    );
  }
}
