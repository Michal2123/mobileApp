import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class DetailProfileMainBaseInfoSection extends StatelessWidget {
  const DetailProfileMainBaseInfoSection(
      {super.key, required this.firstName, required this.distance});
  final String firstName;
  final int distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InputLabelText(
            text: firstName,
            fontSize: 24,
          ),
          LabelText(
            text: '$distance km od Ciebie',
          )
        ],
      ),
    );
  }
}
