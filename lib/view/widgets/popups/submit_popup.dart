import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class SubmitPopup extends StatelessWidget {
  const SubmitPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstant.backgroundScaffoldColor,
      content: const SizedBox(
        height: 200,
        child: Align(
            alignment: Alignment.center,
            child: InputLabelText(text: 'Sukces !')),
      ),
    );
  }
}
