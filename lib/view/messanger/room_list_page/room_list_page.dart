import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/messanger/room_list_page/room_list_sections/friends_list_section.dart';
import 'package:flutter_mobile_app/view/messanger/room_list_page/room_list_sections/room_list_section.dart';
import 'package:flutter_mobile_app/view/messanger/room_list_page/room_list_sections/search_bar_section.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: const Column(children: [
        RoomListSearchBarSection(),
        FriendListSection(),
        Expanded(
          child: RoomListSection(),
        ),
      ]),
    );
  }
}
