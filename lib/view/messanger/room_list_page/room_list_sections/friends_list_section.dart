import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/messanger/room_list_page/room_list_sections/label_section.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/friends_list/friends_list_widget.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class FriendListSection extends StatelessWidget {
  const FriendListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context
            .watch<MessangerConnectionService>()
            .friendsToShowList
            .isNotEmpty
        ? Column(
            children: [
              const RoomListLabelSection(
                title: 'Znajomi',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: ScreenMaxWitdhRatio.heightResize(context, 0.175),
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var friend in context
                            .watch<MessangerConnectionService>()
                            .friendsToShowList)
                          UserFriendsList(
                            friend: friend,
                          )
                      ]),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
