import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class FriendListTitleSection extends StatelessWidget {
  const FriendListTitleSection(
      {super.key, required this.userName, this.defaultRoom});
  final String userName;
  final String? defaultRoom;

  @override
  Widget build(BuildContext context) {
    return InputLabelText(
      text: userName,
      fontSize: 22,
      color: context
              .read<MessangerConnectionService>()
              .roomsList
              .any((element) => element.id == defaultRoom)
          ? ColorConstant.defaultTextColor
          : ColorConstant.inkWellTextColor,
    );
  }
}
