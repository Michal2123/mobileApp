import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_page.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/display_name_section.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/edit_name_section.dart';

class GroupChatMenuNameSection extends StatefulWidget {
  const GroupChatMenuNameSection(
      {super.key, required this.groupChatMenuController});
  final GroupChatMenuController groupChatMenuController;

  @override
  State<GroupChatMenuNameSection> createState() =>
      _GroupChatMenuNameSectionState();
}

class _GroupChatMenuNameSectionState extends State<GroupChatMenuNameSection> {
  bool _showTextField = false;
  final _node = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.groupChatMenuController.getToggleValue = getToggleValue;
      widget.groupChatMenuController.toggleTextField = toggleTextField;
    });
    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  bool getToggleValue() => _showTextField;

  void toggleTextField() {
    setState(() {
      _showTextField = !_showTextField;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _showTextField
            ? GroupChatMenuEditNameSection(
                node: _node,
                toggleTextField: toggleTextField,
              )
            : GroupChatMenuDisplayNameSection(
                node: _node,
                toggleTextField: toggleTextField,
              ));
  }
}
