import 'package:flutter/material.dart';

class ElevationStyledButton extends StatelessWidget {
  const ElevationStyledButton(
      {super.key,
      this.onPressed,
      required this.elevation,
      this.bgColor,
      this.iconColor,
      this.padding,
      required this.icon,
      this.iconSize});
  final IconData icon;
  final Function()? onPressed;
  final double elevation;
  final double? iconSize;
  final Color? bgColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          foregroundColor: bgColor,
          backgroundColor: bgColor,
          shape: const CircleBorder(),
          padding: padding),
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
