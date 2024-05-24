import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class SwipeMainTopSection extends StatelessWidget {
  const SwipeMainTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Align(
          alignment: Alignment.center,
          child: InputLabelText(
            text: 'Poznaj nowych znajomych',
          )),
    );
  }
}
