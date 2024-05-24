import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_sections/friend_section.dart';

class CreatingChatFriendsListSection extends StatefulWidget {
  const CreatingChatFriendsListSection({super.key});

  @override
  State<CreatingChatFriendsListSection> createState() =>
      _CreatingChatFriendsListSectionState();
}

class _CreatingChatFriendsListSectionState
    extends State<CreatingChatFriendsListSection> {
  List<InputFriendModel> _localToShowList = [];
  List<String> _localIdList = [];

  @override
  void didChangeDependencies() {
    _localToShowList =
        context.read<MessangerConnectionService>().friendsToShowList.toList();
    _localIdList =
        context.read<MessangerConnectionService>().friendsidList.toList();
    super.didChangeDependencies();
  }

  void addToSelected(String chatFriendId) {
    _localIdList.add(context
        .read<MessangerConnectionService>()
        .friendsToShowList
        .firstWhere((element) => element.userId == chatFriendId)
        .userId);
    _localToShowList.removeWhere((element) => element.userId == chatFriendId);

    context.read<MessangerConnectionService>().friendsToShowList =
        _localToShowList;
    context.read<MessangerConnectionService>().friendsidList = _localIdList;
  }

  @override
  Widget build(BuildContext context) {
    return context
            .watch<MessangerConnectionService>()
            .friendsToShowList
            .isNotEmpty
        ? Expanded(
            child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                scrollDirection: Axis.vertical,
                children: [
                  for (var friend in context
                      .watch<MessangerConnectionService>()
                      .friendsToShowList)
                    CreatingChatFriendSection(
                      addToSelected: addToSelected,
                      friend: friend,
                    )
                ]),
          )
        : const SizedBox();
  }
}
