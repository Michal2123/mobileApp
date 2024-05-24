import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/input_form_field/input_field_widged.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class ChatBottomBarSection extends StatefulWidget {
  const ChatBottomBarSection({super.key});

  @override
  State<ChatBottomBarSection> createState() => _ChatBottomBarSectionState();
}

class _ChatBottomBarSectionState extends State<ChatBottomBarSection> {
  final TextEditingController messageController = TextEditingController();
  final ContextPopups _contextPopups = ContextPopups();
  bool _isCurrentRoomActive = false;

  @override
  void didChangeDependencies() {
    _isCurrentRoomActive =
        context.read<MessangerConnectionService>().currentRoomOpen?.isActive ??
            false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (_isCurrentRoomActive) {
      var roomId =
          context.read<MessangerConnectionService>().currentRoomOpen?.id;
      if (roomId != null) {
        context.read<MessangerChatService>().sendChatMessage(
              roomId,
              messageController.text,
            );
        setState(() {
          messageController.text = '';
        });
      }
      return;
    }
    _contextPopups.alertPopup(context, 'Ten pokój jest zablokowany');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomeInputField(
                  title: context
                          .read<MessangerConnectionService>()
                          .currentRoomOpen!
                          .isActive
                      ? 'Wpisz wiadomość'
                      : 'Czat zablokowany',
                  name: 'message',
                  obscureText: false,
                  controller: messageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  radius: 20,
                  enableTextField: _isCurrentRoomActive,
                ),
              ),
            ),
            InkWell(
                onTap: () => sendMessage(),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 30,
                  color: _isCurrentRoomActive
                      ? null
                      : ColorConstant.floatingButtonInactiveColor,
                )),
          ],
        ),
      ),
    );
  }
}
