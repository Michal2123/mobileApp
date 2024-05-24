import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_page.dart';
import 'package:flutter_mobile_app/view/messanger/edit_chat_mmembers_page/edit_chat_members_page.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/button_section.dart';

class GroupChatMenuUpperRowSection extends StatelessWidget {
  const GroupChatMenuUpperRowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GroupChatMenuButtonSection(
            icon: Icons.person_add,
            title: 'Dodaj\nczłonka',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CreatingChat())),
          ),
          GroupChatMenuButtonSection(
            icon: Icons.groups,
            title: 'Edytuj\ngrupe',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditChatMembers())),
          ),
          GroupChatMenuButtonSection(
            icon: Icons.notifications_off,
            title: 'Wycisz',
            color: context
                    .watch<MessangerConnectionService>()
                    .currentRoomOpen!
                    .isMuted
                ? ColorConstant.inkWellTextColor
                : null,
            onTap: () => context.read<MessangerRoomService>().muteRoom(),
          ),
        ],
      ),
    );
  }
}
