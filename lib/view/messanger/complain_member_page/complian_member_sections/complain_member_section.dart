import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/messanger_models/chat_complain_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/animated_collapse_widget.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/custome_checkbox_widget.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ComplainMemberSection extends StatefulWidget {
  const ComplainMemberSection(
      {super.key, required this.participantCheckBoxList, required this.member});
  final List<ChatComplainModel> participantCheckBoxList;
  final ParticipantModel member;

  @override
  State<ComplainMemberSection> createState() => _ComplainMemberSectionState();
}

class _ComplainMemberSectionState extends State<ComplainMemberSection> {
  Future<void> collapsAllComplainLists() async {
    for (var participant in widget.participantCheckBoxList) {
      if (participant.isExpand) {
        setState(() {
          participant.isExpand = false;
        });
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  void expandParticipantComplainList(ChatComplainModel participant) {
    collapsAllComplainLists().then((_) => setState(() {
          participant.isExpand = !participant.isExpand;
        }));
  }

  @override
  Widget build(BuildContext context) {
    var participant = widget.participantCheckBoxList
        .where((participant) => participant.id == widget.member.userId)
        .first;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      child: GestureDetector(
        onTap: () => participant.isExpand
            ? collapsAllComplainLists()
            : expandParticipantComplainList(participant),
        child: Column(
          children: [
            Row(
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
              ],
            ),
            AnimatedCollapse(
              expand: participant.isExpand,
              child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.dottedBorderColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        participant.titles.length,
                        (index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: InputLabelText(
                                      text: participant.titles[index],
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: CustomeCheckbox(
                                        isChacked: participant.checkList[index],
                                        onChange: (value) {
                                          setState(
                                            () {
                                              participant.checkList[index] =
                                                  value;
                                            },
                                          );
                                        }),
                                  )
                                ])).toList(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
