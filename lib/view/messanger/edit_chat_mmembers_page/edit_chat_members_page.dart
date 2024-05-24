import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/messanger/edit_chat_mmembers_page/edit_chat_member_sections/button_section.dart';
import 'package:flutter_mobile_app/view/messanger/edit_chat_mmembers_page/edit_chat_member_sections/list_section.dart';
import 'package:flutter_mobile_app/view/messanger/edit_chat_mmembers_page/edit_chat_member_sections/upper_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class EditChatMemberController {
  late List<String> Function() getMembersToRemove;
}

class EditChatMembers extends StatefulWidget {
  const EditChatMembers({super.key});

  @override
  State<EditChatMembers> createState() => _EditChatMembersState();
}

class _EditChatMembersState extends State<EditChatMembers> {
  final EditChatMemberController _editchatMemberController =
      EditChatMemberController();

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: EditChatMemberButtonSection(
        editChatMemberController: _editchatMemberController,
      ),
      unfocusFunction: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: BackArrowNavigation(
        view: Column(children: [
          const EditChatMemberUpperSection(),
          EditChatMemberListSection(
            editChatMemberController: _editchatMemberController,
          )
        ]),
      ),
    );
  }
}
