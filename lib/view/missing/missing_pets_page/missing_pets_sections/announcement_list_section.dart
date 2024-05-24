import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_page.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_page.dart';

class MissingPetsAnnouncementListSection extends StatefulWidget {
  const MissingPetsAnnouncementListSection(
      {super.key,
      required this.scrollController,
      required this.missingPetsController});
  final ScrollController scrollController;
  final MissingPetsController missingPetsController;

  @override
  State<MissingPetsAnnouncementListSection> createState() =>
      _MissingPetsAnnouncementListSectionState();
}

class _MissingPetsAnnouncementListSectionState
    extends State<MissingPetsAnnouncementListSection> {
  MissingPageTabs _currentTab = MissingPageTabs.announcementTab;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.missingPetsController.getToggleValue = getToggleValue;
    });
    super.initState();
  }

  void getToggleValue(MissingPageTabs tab) {
    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MissingPetsList(
      missingPageTabs: _currentTab,
      controller: widget.scrollController,
    );
  }
}
