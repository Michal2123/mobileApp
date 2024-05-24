import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/messanger/chat_page/chat_sections/app_bar_section.dart';
import 'package:flutter_mobile_app/view/messanger/chat_page/chat_sections/bottom_bar_section.dart';
import 'package:flutter_mobile_app/view/messanger/chat_page/chat_sections/message_list_section.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/view/messanger/group_chat_menu_page/group_chat_menu_page.dart';
import 'package:flutter_mobile_app/view/messanger/single_chat_menu_page/single_chat_menu_page.dart';
import 'package:flutter_mobile_app/view/messanger/messanger_page/messanger_page.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';
import 'dart:typed_data';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String _roomName = '';
  OutputRoomModel? _currentRoomOpen;

  //
  Uint8List? _bytes;
  //

  @override
  void didChangeDependencies() {
    _currentRoomOpen =
        context.read<MessangerConnectionService>().currentRoomOpen;
    _roomName = _currentRoomOpen?.roomName ?? '';
    super.didChangeDependencies();
  }

  void leaveRoom() {
    context.read<MessangerConnectionService>().clearCurrentRoom();
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: MainPages.messangerPage.name),
        builder: (context) => const Messanger()));
  }

  void openMenu() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      if (_currentRoomOpen != null) {
        if (_currentRoomOpen?.isGroupChat == true) {
          return const GroupChatMenu();
        }
      }
      return const SingleChatMenu();
    }));
  }

  void unfocusFields() {
    FocusManager.instance.primaryFocus!.unfocus();
    context.read<MessangerChatService>().expDate(null);
  }

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      appbar: ChatAppBarSection(
        roomName: _roomName,
        leaveRoom: leaveRoom,
        openMenu: openMenu,
      ),
      unfocusFunction: () => unfocusFields(),
      child: _currentRoomOpen != null
          ? Column(children: [
              const ChatMessageListSection(),
              const ChatBottomBarSection(),
              if (_bytes != null)
                const Text("Here's the most recently inserted content:"),
              if (_bytes != null) Image.memory(_bytes!),
            ])
          : const SizedBox(),
    );
  }
}
