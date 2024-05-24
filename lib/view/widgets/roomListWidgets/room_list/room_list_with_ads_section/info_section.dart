import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class RoomListWithAdsInfoSection extends StatelessWidget {
  const RoomListWithAdsInfoSection(
      {super.key, required this.title, this.content});
  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InputLabelText(text: title),
          ),
          content != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: LabelText(text: content!),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
