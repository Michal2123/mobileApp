import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton(
      {super.key,
      this.onTap,
      this.elevation,
      this.iconSize,
      this.padding,
      this.size,
      this.bgColor,
      this.iconColor});
  final Function()? onTap;
  final double? size;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final Color? bgColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              elevation: elevation,
              backgroundColor: bgColor ?? ColorConstant.defaultTextColor,
              shape: const CircleBorder(),
              padding: padding),
          child: Icon(
            size: iconSize,
            Icons.close_rounded,
            color: iconColor ?? ColorConstant.buttonTextColor,
          ),
        ));
  }
}
