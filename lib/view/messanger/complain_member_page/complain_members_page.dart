import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/messanger_models/chat_complain_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/complain_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/messanger/complain_member_page/complian_member_sections/list_section.dart';
import 'package:flutter_mobile_app/view/messanger/complain_member_page/complian_member_sections/upper_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';

class ComplainChatMembers extends StatefulWidget {
  const ComplainChatMembers({super.key});

  @override
  State<ComplainChatMembers> createState() => _ComplainChatMembersState();
}

class _ComplainChatMembersState extends State<ComplainChatMembers> {
  final _searchBarTextController = TextEditingController();
  List<ParticipantModel> _chatMembersList = [];
  List<ParticipantModel> _chatMembersListToShow = [];
  final List<ComplainModel> _participantComplainList = [];
  final List<ChatComplainModel> _participantCheckBoxList = [];
  //final ContextPopups _contextPopups = ContextPopups();

  final List<String> _mockComplainsList = [
    'skarga #1',
    'skarga #2',
    'skarga #3',
    'skarga #4',
    'skarga #5',
    'skarga #6',
  ];

  @override
  void dispose() {
    _searchBarTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _searchBarTextController.addListener(searchFor));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatMembersList = Provider.of<MessangerConnectionService>(context)
            .currentRoomOpen
            ?.participants ??
        [];
    participantCheckBoxMapFiller();
    _chatMembersListToShow = _chatMembersList.toList();
  }

  void participantCheckBoxMapFiller() {
    for (var member in _chatMembersList) {
      _participantCheckBoxList.add(ChatComplainModel(
          id: member.userId,
          isExpand: false,
          titles: List.generate(
              _mockComplainsList.length, (index) => _mockComplainsList[index]),
          checkList:
              List.generate(_mockComplainsList.length, (index) => false)));
    }
  }

  void searchFor() {
    setState(() {
      if (_searchBarTextController.text.isEmpty) {
        _chatMembersListToShow = _chatMembersList.toList();
        return;
      }

      _chatMembersListToShow = _chatMembersList
          .where((friend) => friend.userName
              .toLowerCase()
              .contains(_searchBarTextController.text.toLowerCase()))
          .toList();
    });
  }

  void createComplainModel() {
    for (var participant in _participantCheckBoxList) {
      var complainCheckedList = participant.checkList;
      if (complainCheckedList.any((complain) => complain)) {
        List<int> complainIndexList = [];
        for (var i = 0; i < complainCheckedList.length; i++) {
          if (complainCheckedList[i]) {
            complainIndexList.add(i);
          }
        }
        _participantComplainList.add(ComplainModel(
            participantId: participant.id,
            complainEnumList: complainIndexList));
      }
    }
  }

  void complainChatMembersError() {
    Navigator.pop(context);
    ContextPopups().alertPopup(context, 'Nieudało się wysłać skargi');
  }

  Widget floatingButton() {
    return ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus!.unfocus();
          createComplainModel();
          if (_participantComplainList.isNotEmpty) {
            //_contextPopups.loadingIndicator(context);
          }
        },
        child: Text(
          'Zgłoś',
          style: ButtonTextStyle(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      unfocusFunction: () => FocusManager.instance.primaryFocus!.unfocus(),
      showBottomNavigationBar: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingButton(),
      child: BackArrowNavigation(
        view: Column(children: [
          ComplainMemberUpperSection(
            searchBarTextController: _searchBarTextController,
          ),
          ComplainMemberListSection(
            chatMembersListToShow: _chatMembersListToShow,
            participantCheckBoxList: _participantCheckBoxList,
          )
        ]),
      ),
    );
  }
}
