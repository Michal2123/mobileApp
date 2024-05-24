import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/view/messanger/chat_page/chat_page.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_page.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';
import 'package:signalr_netcore/errors.dart';

class CreatingChatButtonSection extends StatefulWidget {
  const CreatingChatButtonSection(
      {super.key, required this.chatUpperSectionController});
  final CreatingChatUpperSectionController chatUpperSectionController;

  @override
  State<CreatingChatButtonSection> createState() =>
      _CreatingChatButtonSectionState();
}

class _CreatingChatButtonSectionState extends State<CreatingChatButtonSection> {
  List<InputFriendModel> _friendsList = [];
  List<String> _localIdList = [];
  final ContextPopups _contextPopups = ContextPopups();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessangerConnectionService>().clearCreatingRoom();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _friendsList =
        context.read<MessangerConnectionService>().friendsList.toList();
    _localIdList =
        context.read<MessangerConnectionService>().friendsidList.toList();
  }

  void showError() {
    context.read<MessangerConnectionService>().friendsidList = [];
    widget.chatUpperSectionController.filterToShowList();
    Navigator.pop(context);
    ContextPopups().alertPopup(context, 'Nieudało się stworzyć czatu');
  }

  Future<void> enterRoom(
    String roomId,
  ) async {
    context
        .read<MessangerRoomService>()
        .enterChatRoom(roomId, _localIdList)
        .then((canEnterRoom) {
      if (canEnterRoom) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Chat()));
      }
      showError();
    }).onError((error, stackTrace) {
      showError();
    });
  }

  void createChat() {
    context.read<MessangerRoomService>().addRoom(_localIdList).then((roomId) {
      Navigator.pop(context);
      enterRoom(roomId);
    }).onError<GeneralError>((error, stackTrace) {
      if (error.message?.contains('Room with specified user alredy exists.') ==
          true) {
        enterRoom(_friendsList
            .firstWhere((friend) => friend.userId == _localIdList.first)
            .defaultRoom!);
        return;
      }
      showError();
    });
  }

  void addParticipant() {
    context
        .read<MessangerChatService>()
        .addParticipantToChat(_localIdList)
        .then((_) {
      Navigator.pop(context);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      showError();
    });
  }

  void submit() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_localIdList.isNotEmpty) {
      _contextPopups.loadingIndicator(context);
      if (context.read<MessangerConnectionService>().currentRoomOpen != null) {
        addParticipant();
        return;
      }
      createChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => submit(),
        child: Text(
          context.read<MessangerConnectionService>().currentRoomOpen != null
              ? 'Dodaj'
              : 'Utwórz czat',
          style: ButtonTextStyle(),
        ));
  }
}
