import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class InputLabelText extends StatelessWidget {
  const InputLabelText({
    super.key,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.align = TextAlign.left,
    this.fontSize = 20,
    this.color,
    this.maxLines,
  });

  final String text;
  final TextOverflow overflow;
  final TextAlign align;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        textAlign: align,
        maxLines: maxLines,
        softWrap: false,
        style: TextStyle(
          color: color ?? ColorConstant.defaultTextColor,
          fontSize: fontSize,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ));
  }
}
