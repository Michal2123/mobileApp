import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/custome_checkbox_widget.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class EditChatMemberSection extends StatefulWidget {
  const EditChatMemberSection(
      {super.key, required this.member, required this.editIdList});
  final ParticipantModel member;
  final Function editIdList;

  @override
  State<EditChatMemberSection> createState() => _EditChatMemberSectionState();
}

class _EditChatMemberSectionState extends State<EditChatMemberSection> {
  bool _isChecked = false;

  void onChange(bool value) {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.editIdList(widget.member.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InputLabelText(
                text: widget.member.userName,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.centerRight,
                child: CustomeCheckbox(
                  heigh: 25,
                  width: 25,
                  iconSize: 21,
                  onChange: onChange,
                )),
          )
        ],
      ),
    );
  }
}
