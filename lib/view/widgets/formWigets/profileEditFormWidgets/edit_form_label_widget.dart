import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ProfileEditFormLabel extends StatelessWidget {
  const ProfileEditFormLabel({super.key, required this.title, this.sufix});
  final String title;
  final Widget? sufix;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(left: 3, top: 20, right: 10),
            child: Row(
              children: [
                InputLabelText(text: title),
                sufix ?? const SizedBox()
              ],
            )));
  }
}
