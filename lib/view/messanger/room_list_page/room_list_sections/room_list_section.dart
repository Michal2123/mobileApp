import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/ad_helper.dart';
import 'package:flutter_mobile_app/helper/mixins/room_service_helpers_mixin.dart';
import 'package:flutter_mobile_app/interface/room_list_item_interface.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/messanger/room_list_page/room_list_sections/label_section.dart';

class RoomListSection extends StatefulWidget {
  const RoomListSection({super.key});

  @override
  State<RoomListSection> createState() => _RoomListSectionState();
}

class _RoomListSectionState extends State<RoomListSection>
    with RoomServiceHelpers {
  List<RoomListItem> _localRoomList = [];
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _localRoomList = generateListOfRooms(
          context.read<MessangerConnectionService>().roomsList);
      context.read<MessangerConnectionService>().roomListToShow =
          AdHelper.roomListAdInserter(_localRoomList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<MessangerConnectionService>().roomListToShow.isNotEmpty
        ? Column(
            children: [
              const RoomListLabelSection(
                title: 'Wiadomości',
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                  child: ListView(
                    children: [
                      for (var room in context
                          .watch<MessangerConnectionService>()
                          .roomListToShow)
                        room.buildRoom(context)
                    ],
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
