import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/messanger/complain_member_page/complain_members_page.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_sections/button_section.dart';

class SingleChatMenuButtonListSection extends StatelessWidget {
  const SingleChatMenuButtonListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GroupChatMenuButtonSection(
                      icon: Icons.notifications_off,
                      title: 'Wycisz',
                      color: context
                              .watch<MessangerConnectionService>()
                              .currentRoomOpen!
                              .isMuted
                          ? null
                          : ColorConstant.inkWellTextColor,
                      onTap: () =>
                          context.read<MessangerRoomService>().muteRoom()),
                  GroupChatMenuButtonSection(
                    icon: Icons.block,
                    title: 'Zablokuj',
                    color: context
                            .watch<MessangerConnectionService>()
                            .currentRoomOpen!
                            .isActive
                        ? null
                        : ColorConstant.inkWellTextColor,
                    onTap: () =>
                        context.read<MessangerRoomService>().changeBlockState(),
                  ),
                  GroupChatMenuButtonSection(
                    icon: Icons.warning_amber_rounded,
                    title: 'Zgłoś',
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ComplainChatMembers())),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
