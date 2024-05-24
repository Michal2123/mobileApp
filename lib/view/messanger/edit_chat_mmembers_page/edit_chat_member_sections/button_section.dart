import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/view/messanger/edit_chat_mmembers_page/edit_chat_members_page.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';

class EditChatMemberButtonSection extends StatefulWidget {
  const EditChatMemberButtonSection(
      {super.key, required this.editChatMemberController});
  final EditChatMemberController editChatMemberController;

  @override
  State<EditChatMemberButtonSection> createState() =>
      _EditChatMemberButtonSectionState();
}

class _EditChatMemberButtonSectionState
    extends State<EditChatMemberButtonSection> {
  List<String> _chatMembersIdRemoveList = [];
  final ContextPopups _contextPopups = ContextPopups();

  void editChatMembersError() {
    Navigator.pop(context);
    ContextPopups().alertPopup(context, 'Nieudało się usunąć członka czatu');
  }

  void submit() {
    FocusManager.instance.primaryFocus!.unfocus();
    _chatMembersIdRemoveList =
        widget.editChatMemberController.getMembersToRemove();
    if (_chatMembersIdRemoveList.isNotEmpty) {
      _contextPopups.loadingIndicator(context);
      context
          .read<MessangerChatService>()
          .removeParticipantfromChat(_chatMembersIdRemoveList)
          .then((_) {
        Navigator.pop(context);
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        editChatMembersError();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => submit(),
        child: Text(
          'Usuń',
          style: ButtonTextStyle(),
        ));
  }
}
