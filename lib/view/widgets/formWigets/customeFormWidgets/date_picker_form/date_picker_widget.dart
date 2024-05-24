import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/input_form_field/input_field_widged.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_default.dart';

class DatePicker extends StatelessWidget {
  DatePicker(
      {super.key,
      required this.dateController,
      this.focusNode,
      this.onChange,
      this.textInputFormatterList,
      this.inputMaskType});

  final TextEditingController dateController;
  final InputTextStyle inputTextStyle = InputTextStyle();
  final FocusNode? focusNode;
  final String? inputMaskType;
  final Function(String)? onChange;
  final List<TextInputFormatter>? textInputFormatterList;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomeInputField(
        padding: const EdgeInsets.all(0),
        textAlign: TextAlign.start,
        style: false,
        controller: dateController,
        title: inputMaskType == 'short' ? 'dd/mm/rrrr' : 'dd/mm/rrrr HH:MM',
        name: 'date',
        onChanged: onChange,
        obscureText: false,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        inputFormatters: textInputFormatterList != null
            ? [
                inputMaskType == 'short'
                    ? textInputFormatterList![0]
                    : textInputFormatterList![1]
              ]
            : [],
      ),
    );
  }
}
