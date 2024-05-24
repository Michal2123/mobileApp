import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/custome_checkbox_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class PopupCheckboxSection extends StatefulWidget {
  const PopupCheckboxSection({super.key, required this.filters});
  final List<Map<String, dynamic>> filters;
  @override
  State<PopupCheckboxSection> createState() => _PopupCheckboxSectionState();
}

class _PopupCheckboxSectionState extends State<PopupCheckboxSection> {
  void onCheck(Map<String, dynamic> filter, bool value) {
    setState(() {
      filter['isChacked'] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      backgroundColor: ColorConstant.backgroundScaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            for (var filter in widget.filters)
              Row(
                children: [
                  CustomeCheckbox(
                    isChacked: filter['isChacked'],
                    onChange: (value) => onCheck(filter, value),
                  ),
                  InputLabelText(
                    text: filter['title'],
                    fontSize: 18,
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
