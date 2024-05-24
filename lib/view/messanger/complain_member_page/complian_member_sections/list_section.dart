import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/messanger_models/chat_complain_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/view/messanger/complain_member_page/complian_member_sections/complain_member_section.dart';

class ComplainMemberListSection extends StatelessWidget {
  const ComplainMemberListSection(
      {super.key,
      required this.chatMembersListToShow,
      required this.participantCheckBoxList});
  final List<ParticipantModel> chatMembersListToShow;
  final List<ChatComplainModel> participantCheckBoxList;

  @override
  Widget build(BuildContext context) {
    return chatMembersListToShow.isNotEmpty
        ? Expanded(
            child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                scrollDirection: Axis.vertical,
                children: [
                  for (var chatMember in chatMembersListToShow)
                    ComplainMemberSection(
                      participantCheckBoxList: participantCheckBoxList,
                      member: chatMember,
                    )
                ]),
          )
        : const SizedBox();
  }
}
