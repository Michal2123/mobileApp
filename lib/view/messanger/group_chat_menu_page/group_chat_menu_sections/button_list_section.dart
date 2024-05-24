import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/lower_button_row_section.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/upper_button_row_section.dart';

class GroupChatMenuButtonList extends StatelessWidget {
  const GroupChatMenuButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            GroupChatMenuUpperRowSection(),
            GroupChatMenuLowerButtonRowSection(),
          ],
        ));
  }
}
