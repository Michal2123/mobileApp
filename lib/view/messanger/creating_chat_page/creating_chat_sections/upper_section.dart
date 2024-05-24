import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_page.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_sections/tag_section.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class CreatinChatUpperSection extends StatefulWidget {
  const CreatinChatUpperSection(
      {super.key, required this.chatUpperSectionController});
  final CreatingChatUpperSectionController chatUpperSectionController;

  @override
  State<CreatinChatUpperSection> createState() =>
      _CreatinChatUpperSectionState();
}

class _CreatinChatUpperSectionState extends State<CreatinChatUpperSection> {
  final TextEditingController _searchBarTextController =
      TextEditingController();
  List<InputFriendModel> _localToShowList = [];
  List<String> _localIdList = [];

  @override
  void initState() {
    _searchBarTextController.addListener(searchFor);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.chatUpperSectionController.filterToShowList = filterToShowList;
      filterToShowList();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localToShowList =
        context.read<MessangerConnectionService>().friendsToShowList.toList();
    _localIdList =
        context.read<MessangerConnectionService>().friendsidList.toList();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchBarTextController.dispose();
    super.dispose();
  }

  void filterToShowList() {
    var currentRoomOpen =
        context.read<MessangerConnectionService>().currentRoomOpen;
    if (currentRoomOpen != null) {
      context.read<MessangerConnectionService>().friendsToShowList = context
          .read<MessangerConnectionService>()
          .friendsList
          .where((friend) => currentRoomOpen.participants
              .any((participant) => friend.userId == participant.userId))
          .toList();
    }

    searchFromFrindsList();
  }

  void searchFromFrindsList() {
    context.read<MessangerConnectionService>().friendsToShowList = context
        .read<MessangerConnectionService>()
        .friendsList
        .where((friend) =>
            friend.userName
                .toLowerCase()
                .contains(_searchBarTextController.text.toLowerCase()) &&
            !context
                .read<MessangerConnectionService>()
                .friendsidList
                .any((id) => id == friend.userId))
        .toList();
  }

  void searchFor() {
    if (_searchBarTextController.text.isEmpty) {
      context.read<MessangerConnectionService>().friendsToShowList = context
          .read<MessangerConnectionService>()
          .friendsList
          .where((friend) => !context
              .read<MessangerConnectionService>()
              .friendsidList
              .any((id) => id == friend.userId))
          .toList();
      return;
    }
    searchFromFrindsList();
  }

  void removeFromSelected(String chatFriendId) {
    _localToShowList.add(context
        .read<MessangerConnectionService>()
        .friendsList
        .firstWhere((element) => element.userId == chatFriendId));
    _localIdList.removeWhere((element) => element == chatFriendId);

    context.read<MessangerConnectionService>().friendsToShowList =
        _localToShowList;
    context.read<MessangerConnectionService>().friendsidList = _localIdList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child:
              context.read<MessangerConnectionService>().currentRoomOpen != null
                  ? const InputLabelText(text: 'Dodaj członka')
                  : const InputLabelText(text: 'Nowy czat'),
        ),
        CustomeSearchBar(
          searchBarTextController: _searchBarTextController,
          clearController: () => _searchBarTextController.clear(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: <Widget>[
              for (var chatFriendId
                  in context.watch<MessangerConnectionService>().friendsidList)
                GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      removeFromSelected(chatFriendId);
                    },
                    child: CreatingChatTagSection(
                      selectedFriendName: context
                          .read<MessangerConnectionService>()
                          .friendsList
                          .firstWhere((friend) => friend.userId == chatFriendId)
                          .userName,
                    ))
            ],
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 5, left: 15, right: 15),
            child: InputLabelText(text: 'Znajomi'),
          ),
        )
      ],
    );
  }
}
