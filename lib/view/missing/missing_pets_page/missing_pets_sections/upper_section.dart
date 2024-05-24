import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_sections/add_button_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_sections/tab_buttons_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class MissingPetsUpperSection extends StatefulWidget {
  const MissingPetsUpperSection(
      {super.key, required this.scrollController, required this.toggleTab});
  final ScrollController scrollController;
  final Function(MissingPageTabs) toggleTab;

  @override
  State<MissingPetsUpperSection> createState() =>
      _MissingPetsUpperSectionState();
}

class _MissingPetsUpperSectionState extends State<MissingPetsUpperSection> {
  MissingPageTabs _currentTab = MissingPageTabs.announcementTab;

  void toggleTab(MissingPageTabs tab) {
    if (widget.scrollController.hasClients) {
      widget.scrollController.jumpTo(0);
    }
    setState(() {
      _currentTab = tab;
    });
    widget.toggleTab(_currentTab);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: InputLabelText(text: 'Zaginione zwierzęta'),
        ),
        MissingPetsTabButtonSection(
          tabController: _currentTab,
          toggleFunction: toggleTab,
        ),
        !_currentTab.value
            ? const MissingPetsAddButtonSection()
            : const SizedBox()
      ],
    );
  }
}
