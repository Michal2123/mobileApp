import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/messanger/edit_chat_mmembers_page/edit_chat_member_sections/edit_chat_member_section.dart';
import 'package:flutter_mobile_app/view/messanger/edit_chat_mmembers_page/edit_chat_members_page.dart';

class EditChatMemberListSection extends StatefulWidget {
  const EditChatMemberListSection(
      {super.key, required this.editChatMemberController});
  final EditChatMemberController editChatMemberController;

  @override
  State<EditChatMemberListSection> createState() =>
      _EditChatMemberListSectionState();
}

class _EditChatMemberListSectionState extends State<EditChatMemberListSection> {
  final List<String> _idToRemoveList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.editChatMemberController.getMembersToRemove = getMembersToRemove;
    });
    super.initState();
  }

  List<String> getMembersToRemove() {
    return _idToRemoveList;
  }

  void editIdList(String id) {
    if (_idToRemoveList.contains(id)) {
      _idToRemoveList.removeWhere((idFromList) => idFromList == id);
    }
    _idToRemoveList.add(id);
  }

  @override
  Widget build(BuildContext context) {
    return context
            .watch<MessangerConnectionService>()
            .chatMembesrsToShow
            .isNotEmpty
        ? Expanded(
            child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                scrollDirection: Axis.vertical,
                children: [
                  for (var chatMember in context
                      .watch<MessangerConnectionService>()
                      .chatMembesrsToShow)
                    EditChatMemberSection(
                      member: chatMember,
                      editIdList: editIdList,
                    )
                ]),
          )
        : const SizedBox();
  }
}
