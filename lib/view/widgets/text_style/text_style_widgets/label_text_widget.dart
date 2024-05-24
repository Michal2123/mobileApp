import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class LabelText extends StatelessWidget {
  const LabelText(
      {super.key, required this.text, this.fontSize = 17, this.maxLines});

  final String text;
  final double fontSize;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        maxLines: maxLines,
        style: TextStyle(
          color: ColorConstant.defaultTextColor,
          fontSize: fontSize,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
        ));
  }
}
