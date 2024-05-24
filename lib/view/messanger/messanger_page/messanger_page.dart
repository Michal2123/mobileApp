import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/messanger/messanger_page/messanger_sections/floating_action_button_section.dart';
import 'package:flutter_mobile_app/view/messanger/messanger_page/messanger_sections/list_section.dart';
import 'package:flutter_mobile_app/view/messanger/messanger_page/messanger_sections/upper_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class MessangerController {
  late Function(MessangerPageTabs) getToggleValue;
}

class Messanger extends StatefulWidget {
  const Messanger({super.key});

  @override
  State<Messanger> createState() => _Messanger();
}

class _Messanger extends State<Messanger> {
  final _messangerController = MessangerController();

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const FloatingActionButtonSection(),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const MessangerUpperSection(),
            MessangerListSection(
              messangerController: _messangerController,
            ),
          ],
        ),
      ),
    );
  }
}
