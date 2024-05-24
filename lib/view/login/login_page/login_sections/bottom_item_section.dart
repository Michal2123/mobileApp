import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/inkwell_text_widget.dart';

class LoginBottomItemSection extends StatelessWidget {
  const LoginBottomItemSection(
      {super.key, required this.title, required this.onTap});
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: InkWell(
            onTap: onTap,
            child: InkWellText(
              text: title,
              weight: FontWeight.w600,
            )),
      ),
    );
  }
}
