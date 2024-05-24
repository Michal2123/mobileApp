import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class EditChatMemberUpperSection extends StatefulWidget {
  const EditChatMemberUpperSection({super.key});

  @override
  State<EditChatMemberUpperSection> createState() =>
      _EditChatMemberUpperSectionState();
}

class _EditChatMemberUpperSectionState
    extends State<EditChatMemberUpperSection> {
  final _searchBarTextController = TextEditingController();
  List<ParticipantModel> _chatMembersList = [];

  @override
  void initState() {
    super.initState();
    _searchBarTextController.addListener(searchFor);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatMembersList = context
        .read<MessangerConnectionService>()
        .currentRoomOpen!
        .participants;
  }

  @override
  void dispose() {
    _searchBarTextController.dispose();
    super.dispose();
  }

  void searchFor() {
    setState(() {
      if (_searchBarTextController.text.isEmpty) {
        context.read<MessangerConnectionService>().chatMembesrsToShow =
            _chatMembersList.toList();
        return;
      }

      context.read<MessangerConnectionService>().chatMembesrsToShow =
          _chatMembersList
              .where((friend) => friend.userName
                  .toLowerCase()
                  .contains(_searchBarTextController.text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: InputLabelText(text: 'Usuń członka czatu')),
        CustomeSearchBar(
          searchBarTextController: _searchBarTextController,
          clearController: () => _searchBarTextController.clear(),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 5, left: 15, right: 15),
            child: InputLabelText(text: 'Członkowie'),
          ),
        )
      ],
    );
  }
}
