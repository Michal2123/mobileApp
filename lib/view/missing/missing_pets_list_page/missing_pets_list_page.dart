import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_sections/announcement_list_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_sections/list_refresh_indicator_anim_section.dart';

class MissingPetsListController {
  late Function(bool) getIsLoading;
}

class MissingPetsList extends StatelessWidget {
  MissingPetsList(
      {super.key, required this.controller, required this.missingPageTabs});
  final ScrollController controller;
  final MissingPageTabs missingPageTabs;
  final MissingPetsListController _missingPetsListController =
      MissingPetsListController();

  void onLoading(bool value) {
    _missingPetsListController.getIsLoading(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MissingPetsAnnouncementListSection(
            controller: controller,
            missingPageTabs: missingPageTabs,
            onLoading: onLoading,
          ),
        ),
        MissingPetsListRefreshIndicatorAnimSection(
          missingPetsListController: _missingPetsListController,
        ),
      ],
    );
  }
}
