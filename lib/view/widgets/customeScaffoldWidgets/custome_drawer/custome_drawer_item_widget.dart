import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class CustomeDrawerItem extends StatelessWidget {
  const CustomeDrawerItem(
      {super.key,
      required this.icon,
      required this.title,
      this.onTap,
      required this.titleColor});
  final Function()? onTap;
  final IconData icon;
  final Color? titleColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: titleColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InputLabelText(
              color: titleColor,
              fontSize: 24,
              text: title,
            ),
          )
        ],
      ),
    );
  }
}
