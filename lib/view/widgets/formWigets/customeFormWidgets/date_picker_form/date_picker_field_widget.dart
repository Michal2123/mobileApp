import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/date_picker_form/date_picker_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField(
      {super.key,
      required this.controller,
      required this.expand,
      this.onChange,
      this.textInputFormatterList,
      this.missingDateFocusNode,
      this.inputMastType,
      required this.title});
  final TextEditingController controller;
  final bool expand;
  final FocusNode? missingDateFocusNode;
  final Function(String)? onChange;
  final List<TextInputFormatter>? textInputFormatterList;
  final String? inputMastType;
  final String title;
  @override
  Widget build(BuildContext context) {
    return expand
        ? DatePicker(
            onChange: onChange,
            focusNode: missingDateFocusNode,
            dateController: controller,
            inputMaskType: inputMastType,
            textInputFormatterList: textInputFormatterList,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: LabelText(
                text: controller.text.isNotEmpty ? controller.text : title),
          );
  }
}
