import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class GroupChatMenuDisplayNameSection extends StatelessWidget {
  const GroupChatMenuDisplayNameSection(
      {super.key, required this.node, required this.toggleTextField});
  final FocusNode node;
  final Function toggleTextField;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InputLabelText(
              text: context
                  .read<MessangerConnectionService>()
                  .currentRoomOpen!
                  .roomName,
              maxLines: 10,
              fontSize: 28,
              align: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () {
              toggleTextField();
              node.requestFocus();
            },
            child: Icon(
              Icons.edit,
              size: 35,
              color: ColorConstant.inkWellTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
