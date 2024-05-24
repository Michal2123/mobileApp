import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/interface/room_list_item_interface.dart';
import 'package:flutter_mobile_app/model/ad_modes.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/room_list/room_list_with_ads_widget.dart';

class AdItem implements RoomListItem {
  AdItem({required this.adModel});
  final RoomListAdModel adModel;

  @override
  String? get roomName => null;

  @override
  Widget buildRoom(BuildContext context) => RoomListWithAdItem(
      isActive: true,
      roomName: adModel.title,
      content: adModel.content,
      date: adModel.describe,
      onClickFunction: () => FocusManager.instance.primaryFocus!.unfocus());
}
