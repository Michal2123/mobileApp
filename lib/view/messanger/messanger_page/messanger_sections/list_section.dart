import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/messanger/messanger_page/messanger_page.dart';
import 'package:flutter_mobile_app/view/messanger/notifications_page/notifications_page.dart';
import 'package:flutter_mobile_app/view/messanger/room_list_page/room_list_page.dart';

class MessangerListSection extends StatefulWidget {
  const MessangerListSection({super.key, required this.messangerController});
  final MessangerController messangerController;

  @override
  State<MessangerListSection> createState() => _MessangerListSectionState();
}

class _MessangerListSectionState extends State<MessangerListSection> {
  MessangerPageTabs _currentTab = MessangerPageTabs.roomList;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.messangerController.getToggleValue = getToggleValue;
    });
    super.initState();
  }

  void getToggleValue(MessangerPageTabs tab) {
    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: _currentTab.value ? const RoomList() : const Notifications());
  }
}
