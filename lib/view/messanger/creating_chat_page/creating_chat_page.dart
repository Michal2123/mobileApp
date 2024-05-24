import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_sections/button_section.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_sections/friends_list_section.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_sections/upper_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class CreatingChatUpperSectionController {
  late void Function() filterToShowList;
}

class CreatingChat extends StatefulWidget {
  const CreatingChat({super.key});

  @override
  State<CreatingChat> createState() => _CreatingChatState();
}

class _CreatingChatState extends State<CreatingChat> {
  final CreatingChatUpperSectionController _chatUpperSectionController =
      CreatingChatUpperSectionController();

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CreatingChatButtonSection(
          chatUpperSectionController: _chatUpperSectionController),
      unfocusFunction: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: BackArrowNavigation(
        view: Column(children: [
          CreatinChatUpperSection(
            chatUpperSectionController: _chatUpperSectionController,
          ),
          const CreatingChatFriendsListSection(),
        ]),
      ),
    );
  }
}
