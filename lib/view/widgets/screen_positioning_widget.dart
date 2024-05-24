import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenMaxWitdhRatio extends StatelessWidget {
  const ScreenMaxWitdhRatio({super.key, required this.child});
  final Widget child;
  static double maxWidth = 400;

  static double heightResize(BuildContext context, double ratio) {
    if (MediaQuery.of(context).size.width > maxWidth) {
      var temp = (MediaQuery.of(context).size.height /
              MediaQuery.of(context).size.width) *
          maxWidth;

      return temp * ratio;
    }
    return MediaQuery.of(context).size.height * ratio;
  }

  static double getMaxWidth(BuildContext context) {
    return MediaQuery.of(context).size.width < maxWidth
        ? MediaQuery.of(context).size.width
        : maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
