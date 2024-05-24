import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class TagText extends StatelessWidget {
  const TagText({super.key, required this.text, this.color});

  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: color ?? ColorConstant.defaultTextColor,
          fontSize: 18,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
        ));
  }
}
