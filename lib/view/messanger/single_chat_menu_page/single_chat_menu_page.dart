import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/messanger/single_chat_menu_page/single_chat_menu_sections/button_list_section.dart';
import 'package:flutter_mobile_app/view/messanger/single_chat_menu_page/single_chat_menu_sections/upper_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class SingleChatMenu extends StatelessWidget {
  const SingleChatMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomeScaffold(
      showBottomNavigationBar: false,
      child: BackArrowNavigation(
        view: Padding(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChatMenuUpperSection(),
              SingleChatMenuButtonListSection()
            ],
          ),
        ),
      ),
    );
  }
}
