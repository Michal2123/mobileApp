import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/tag_text_widget.dart';

class CreatingChatTagSection extends StatelessWidget {
  const CreatingChatTagSection({super.key, required this.selectedFriendName});
  final String selectedFriendName;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          border: Border.all(
            color: ColorConstant.defaultTextColor,
            width: 1.00,
          ),
        ),
        child: TagText(
          text: selectedFriendName,
          color: ColorConstant.defaultTextColor,
        ));
  }
}
