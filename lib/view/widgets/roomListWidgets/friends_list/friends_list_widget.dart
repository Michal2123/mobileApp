import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/view/messanger/chat_page/chat_page.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/friends_list/firend_list_sections/image_section.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/friends_list/firend_list_sections/title_section.dart';

class UserFriendsList extends StatelessWidget {
  final InputFriendModel friend;
  const UserFriendsList({super.key, required this.friend});

  void onTap(BuildContext context) {
    context
        .read<MessangerRoomService>()
        .addRoom([friend.userId], friend.defaultRoom).then((roomId) {
      context
          .read<MessangerRoomService>()
          .enterChatRoom(roomId, [friend.userId]).then((canEnterRoom) => {
                if (canEnterRoom)
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Chat()))
                  }
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Column(
          children: [
            FiendListImageSection(
              defaultRoom: friend.defaultRoom,
            ),
            FriendListTitleSection(
              userName: friend.userName,
              defaultRoom: friend.defaultRoom,
            )
          ],
        ),
      ),
    );
  }
}
