import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiwi/kiwi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/messanger/chat_page/chat_sections/message_section.dart';

class ChatMessageListSection extends StatefulWidget {
  const ChatMessageListSection({super.key});

  @override
  State<ChatMessageListSection> createState() => _ChatMessageListSectionState();
}

class _ChatMessageListSectionState extends State<ChatMessageListSection> {
  final ScrollController scrollController = ScrollController();
  final _storage = KiwiContainer().resolve<FlutterSecureStorage>();
  String? _userId = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    updateUserId();
  }

  updateUserId() async {
    await _storage.read(key: StorageKeys.userId.name).then((value) => {
          setState(() {
            _userId = value!;
          })
        });
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !_isLoading) {
      setState(() {
        _isLoading = !_isLoading;
      });
      context
          .read<MessangerChatService>()
          .getOlderMessages(
              context.read<MessangerConnectionService>().currentRoomOpen?.id)
          .then((value) {
        setState(() {
          _isLoading = !_isLoading;
        });
      }).catchError((err) {
        setState(() {
          _isLoading = !_isLoading;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: _userId!.isNotEmpty
            ? Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Padding(
                      padding: _isLoading
                          ? const EdgeInsets.all(10)
                          : const EdgeInsets.all(0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 50),
                              width: _isLoading ? 25 : 0,
                              height: _isLoading ? 25 : 0,
                              child: CircularProgressIndicator(
                                color: ColorConstant.inkWellTextColor,
                              ))),
                    ),
                  ),
                  ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: context
                        .watch<MessangerConnectionService>()
                        .chatMessages
                        .length,
                    itemBuilder: (context, index) {
                      return ChatMessageSection(
                        chatMessage: context
                            .watch<MessangerConnectionService>()
                            .chatMessages[index],
                        index: index,
                        userId: _userId,
                      );
                    },
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
