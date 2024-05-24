import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/room_list/room_list_with_ads_section/image_section.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/room_list/room_list_with_ads_section/info_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class RoomListWithAdItem extends StatelessWidget {
  const RoomListWithAdItem(
      {super.key,
      required this.isActive,
      required this.roomName,
      required this.content,
      required this.date,
      required this.onClickFunction});

  final bool isActive;
  final String roomName;
  final String? content;
  final String date;
  final GestureTapCallback onClickFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isActive ? null : ColorConstant.floatingButtonInactiveColor),
      child: GestureDetector(
        onTap: onClickFunction,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const RoomListWithAdsImageSection(),
              RoomListWithAdsInfoSection(
                title: roomName,
                content: content,
              ),
              content != null ? LabelText(text: date) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
