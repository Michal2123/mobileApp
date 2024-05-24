import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/button_list_section.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/name_section.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/image_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class GroupChatMenuController {
  late Function() toggleTextField;
  late bool Function() getToggleValue;
}

class GroupChatMenu extends StatefulWidget {
  const GroupChatMenu({super.key});

  @override
  State<GroupChatMenu> createState() => _GroupChatMenuState();
}

class _GroupChatMenuState extends State<GroupChatMenu> {
  final _groupChatMenuController = GroupChatMenuController();

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      unfocusFunction: () {
        FocusManager.instance.primaryFocus!.unfocus();
        if (_groupChatMenuController.getToggleValue()) {
          _groupChatMenuController.toggleTextField();
        }
      },
      child: BackArrowNavigation(
        view: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 15),
          child: Column(children: [
            const SizedBox(
                height: 110, width: 110, child: GroupChatMenuImageSection()),
            GroupChatMenuNameSection(
              groupChatMenuController: _groupChatMenuController,
            ),
            const GroupChatMenuButtonList(),
          ]),
        ),
      ),
    );
  }
}
