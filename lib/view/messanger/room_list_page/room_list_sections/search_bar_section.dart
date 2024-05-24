import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/ad_helper.dart';
import 'package:flutter_mobile_app/helper/mixins/room_service_helpers_mixin.dart';
import 'package:flutter_mobile_app/interface/room_list_item_interface.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_widget.dart';

class RoomListSearchBarSection extends StatefulWidget {
  const RoomListSearchBarSection({super.key});
  @override
  State<RoomListSearchBarSection> createState() =>
      _RoomListSearchBarSectionState();
}

class _RoomListSearchBarSectionState extends State<RoomListSearchBarSection>
    with RoomServiceHelpers {
  final _searchBarTextController = TextEditingController();
  List<RoomListItem> _localRoomList = [];
  List<InputFriendModel> _localFriendsList = [];

  @override
  void initState() {
    super.initState();
    _searchBarTextController.addListener(searchFor);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asignLocalVerbles();
      context.read<MessangerConnectionService>().roomListToShow =
          AdHelper.roomListAdInserter(_localRoomList);
      context.read<MessangerConnectionService>().friendsToShowList =
          _localFriendsList;
    });
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asignLocalVerbles();
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchBarTextController.dispose();
    super.dispose();
  }

  void asignLocalVerbles() {
    _localRoomList = generateListOfRooms(
        context.read<MessangerConnectionService>().roomsList);
    _localFriendsList = context.read<MessangerConnectionService>().friendsList;
  }

  void searchFor() {
    if (_searchBarTextController.text.isEmpty) {
      context.read<MessangerConnectionService>().roomListToShow =
          AdHelper.roomListAdInserter(_localRoomList);
      context.read<MessangerConnectionService>().friendsToShowList =
          _localFriendsList;
      return;
    }
    context.read<MessangerConnectionService>().roomListToShow = _localRoomList
        .where((room) => room.roomName!
            .toLowerCase()
            .contains(_searchBarTextController.text.toLowerCase()))
        .toList();

    context.read<MessangerConnectionService>().friendsToShowList =
        _localFriendsList
            .where((friend) => friend.userName
                .toLowerCase()
                .contains(_searchBarTextController.text.toLowerCase()))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomeSearchBar(
      searchBarTextController: _searchBarTextController,
      clearController: () => _searchBarTextController.clear(),
    );
  }
}
