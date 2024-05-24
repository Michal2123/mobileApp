import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/popups/checkbox_popup/checkbox_popup_sections/button_section.dart';
import 'package:flutter_mobile_app/view/widgets/popups/checkbox_popup/checkbox_popup_sections/checkbox_section.dart';

class StatefulPopup extends StatelessWidget {
  const StatefulPopup(
      {super.key, required this.filters, required this.filterSubmitFunction});
  final List<Map<String, dynamic>> filters;
  final GestureTapCallback filterSubmitFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PopupCheckboxSection(
          filters: filters,
        ),
        CheckBoxPopupButtonSection(
          filterSubmitFunction: filterSubmitFunction,
        )
      ],
    );
  }
}
