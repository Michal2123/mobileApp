import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/input_form_field/input_field_widged.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class GroupChatMenuEditNameSection extends StatefulWidget {
  const GroupChatMenuEditNameSection(
      {super.key, required this.node, required this.toggleTextField});
  final FocusNode node;
  final Function toggleTextField;

  @override
  State<GroupChatMenuEditNameSection> createState() =>
      _GroupChatMenuEditNameSection();
}

class _GroupChatMenuEditNameSection
    extends State<GroupChatMenuEditNameSection> {
  final _roomNameTextController = TextEditingController();

  @override
  void didChangeDependencies() {
    _roomNameTextController.text =
        Provider.of<MessangerConnectionService>(context)
            .currentRoomOpen!
            .roomName;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _roomNameTextController.dispose();
    super.dispose();
  }

  void submit() {
    if (_roomNameTextController.text.isNotEmpty) {
      ContextPopups().loadingIndicator(context);
      context
          .read<MessangerRoomService>()
          .chagneRoomName(
              context.read<MessangerConnectionService>().currentRoomOpen!.id,
              _roomNameTextController.text)
          .then(
        (_) {
          Navigator.of(context).pop();
          widget.toggleTextField();
        },
      ).onError((_, __) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: CustomeInputField(
              title: context
                  .read<MessangerConnectionService>()
                  .currentRoomOpen!
                  .roomName,
              name: 'room name',
              style: false,
              obscureText: false,
              controller: _roomNameTextController,
              focusNode: widget.node,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name),
        ),
        GestureDetector(
          onTap: () => submit(),
          child: Icon(
            Icons.check,
            size: 35,
            color: ColorConstant.inkWellTextColor,
          ),
        ),
      ],
    );
  }
}
