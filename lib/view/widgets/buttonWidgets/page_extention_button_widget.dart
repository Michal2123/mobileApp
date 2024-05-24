import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class PageExtentionButton extends StatelessWidget {
  const PageExtentionButton(
      {super.key, required this.text, required this.controller});

  final bool controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: controller
            ? ColorConstant.inkWellTextColor
            : ColorConstant.backgroundScaffoldColor,
        border: Border.all(
          color: ColorConstant.backgroundScaffoldColor,
          width: 1.00,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: InputLabelText(
          text: text,
          color: controller ? ColorConstant.backgroundScaffoldColor : null,
          fontSize: 20,
        ),
      ),
    );
  }
}
