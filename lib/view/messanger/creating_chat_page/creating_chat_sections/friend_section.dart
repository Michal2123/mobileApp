import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class CreatingChatFriendSection extends StatefulWidget {
  const CreatingChatFriendSection(
      {super.key, required this.addToSelected, required this.friend});
  final Function(String chatFriendId) addToSelected;
  final InputFriendModel friend;

  @override
  State<CreatingChatFriendSection> createState() =>
      _CreatingChatFriendSectionState();
}

class _CreatingChatFriendSectionState extends State<CreatingChatFriendSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
          widget.addToSelected(widget.friend.userId);
        },
        child: Row(
          children: [
            Container(
              width: ScreenMaxWitdhRatio.heightResize(context, 0.11),
              height: ScreenMaxWitdhRatio.heightResize(context, 0.11),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 1,
                    color: ColorConstant.defaultTextColor,
                  )),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: FlutterLogo(
                  size: 45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InputLabelText(
                text: widget.friend.userName,
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
