import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class MessangerUpperSection extends StatelessWidget {
  const MessangerUpperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: InputLabelText(text: 'Chat'),
    );
  }
}
