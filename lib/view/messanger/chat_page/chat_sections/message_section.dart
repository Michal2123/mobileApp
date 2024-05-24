import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_default.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class ChatMessageSection extends StatelessWidget {
  const ChatMessageSection(
      {super.key,
      required this.chatMessage,
      required this.index,
      required this.userId});
  final ChatMessageModel chatMessage;
  final int index;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: chatMessage.message.userId == userId
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                chatMessage.message.userId == userId
                    ? const SizedBox()
                    : const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: FlutterLogo(
                          size: 20,
                        ),
                      ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: chatMessage.message.userId == userId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<MessangerChatService>().expDate(index);
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              chatMessage.message.content,
                              style: InputTextStyle(),
                            ),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: chatMessage.expDate,
                        builder: (context, value, child) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            height: value ? 20 : 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: LabelText(
                                  text: DateTime.parse(chatMessage.message.date)
                                      .toString()),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
