import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class InkWellText extends StatelessWidget {
  const InkWellText({super.key, required this.text, this.weight});

  final String text;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: ColorConstant.inkWellTextColor,
          fontSize: 20,
          fontFamily: "Nunito",
          fontWeight: weight ?? FontWeight.w400,
        ));
  }
}
