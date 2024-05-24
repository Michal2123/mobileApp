import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/view/messanger/complain_member_page/complain_members_page.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/button_section.dart';
import 'package:flutter_mobile_app/view/messanger/room_list_page/room_list_page.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class GroupChatMenuLowerButtonRowSection extends StatelessWidget {
  const GroupChatMenuLowerButtonRowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GroupChatMenuButtonSection(
            icon: Icons.warning_amber_rounded,
            title: 'Zgłoś',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ComplainChatMembers())),
          ),
          GroupChatMenuButtonSection(
            icon: Icons.exit_to_app,
            title: 'Opóść\nchat',
            onTap: () {
              ContextPopups()
                  .decisionPopup(
                      context, 'Czy napewno chcesz opuścić tan pokój?')
                  .then((value) {
                Navigator.pop(context);
                if (value) {
                  context
                      .read<MessangerRoomService>()
                      .leaveRoom(context
                          .read<MessangerConnectionService>()
                          .currentRoomOpen!
                          .id)
                      .then((_) => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RoomList())));
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
