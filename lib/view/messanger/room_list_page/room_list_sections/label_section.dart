
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class RoomListLabelSection extends StatelessWidget {
  const RoomListLabelSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Align(
          alignment: Alignment.centerLeft, child: InputLabelText(text: title)),
    );
  }
}
