import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/mixins/message_view_helper_mixin.dart';
import 'package:flutter_mobile_app/interface/room_list_item_interface.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/view/messanger/chat_page/chat_page.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/room_list/room_list_with_ads_widget.dart';

class RoomItem with MessageViewHelper implements RoomListItem {
  RoomItem({required this.roomModel});
  final OutputRoomModel roomModel;

  @override
  String? get roomName => roomModel.roomName;

  @override
  Widget buildRoom(BuildContext context) => RoomListWithAdItem(
      isActive: roomModel.isActive,
      roomName: roomModel.roomName,
      content:
          roomModel.lastMessage != null ? roomModel.lastMessage!.content : '',
      date: messageDateParser(
          roomModel.lastMessage != null ? roomModel.lastMessage!.date : ''),
      onClickFunction: () => onClick(context));

  void onClick(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
    context.read<MessangerRoomService>().enterChatRoom(roomModel.id).then((_) =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Chat())));
  }
}
