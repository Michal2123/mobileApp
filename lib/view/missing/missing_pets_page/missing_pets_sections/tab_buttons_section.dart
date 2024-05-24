import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/page_extention_button_widget.dart';

class MissingPetsTabButtonSection extends StatelessWidget {
  const MissingPetsTabButtonSection(
      {super.key, required this.tabController, required this.toggleFunction});
  final MissingPageTabs tabController;
  final Function(MissingPageTabs) toggleFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () => toggleFunction(MissingPageTabs.announcementTab),
              child: PageExtentionButton(
                  text: 'Aktualne', controller: tabController.value)),
          GestureDetector(
              onTap: () {
                toggleFunction(MissingPageTabs.myAnnouncementTab);
                context.read<EditDogService>().get();
              },
              child: PageExtentionButton(
                  text: 'Moje ogłoszenia', controller: !tabController.value)),
        ],
      ),
    );
  }
}
