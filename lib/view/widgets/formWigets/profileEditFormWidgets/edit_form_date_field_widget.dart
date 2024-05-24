import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/date_picker_form/date_picker_form_field_widget.dart';

class ProfileEditFormDateField extends StatefulWidget {
  const ProfileEditFormDateField(
      {super.key,
      required this.controllerValue,
      required this.name,
      required this.validator,
      required this.textInputFormatterList,
      required this.saveControllerData,
      this.inputMastType});
  final String name;
  final String controllerValue;
  final String? Function(TextEditingValue?) validator;
  final List<TextInputFormatter>? textInputFormatterList;
  final Function(Map<String, String>) saveControllerData;
  final String? inputMastType;

  @override
  State<ProfileEditFormDateField> createState() =>
      _MissingPetFormDateFieldSectionState();
}

class _MissingPetFormDateFieldSectionState
    extends State<ProfileEditFormDateField> {
  final TextEditingController _controller = TextEditingController();
  bool _expandController = false;
  final FocusNode _focusNode = FocusNode();
  DateTime? _missingDateToSend;
  @override
  void initState() {
    super.initState();
    if (widget.controllerValue.isNotEmpty) {
      parseModelDate();
    }
    _focusNode.addListener(focusHandler);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void expandHandler() {
    _focusNode.requestFocus();
    setState(() {
      _expandController = true;
    });
  }

  void collapseField() {
    missingDataPickerOutputCheck();
    setState(() {
      _expandController = false;
    });
  }

  void focusHandler() {
    if (!_focusNode.hasFocus) {
      _focusNode.unfocus();
      collapseField();
    }
  }

  void parseModelDate() {
    var date = DateTime.parse(widget.controllerValue);
    _controller.text =
        '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    missingDataPickerOutputCheck();
  }

  void missingDataPickerOutputCheck() {
    try {
      var fullDate = _controller.text.split(' ');
      var date = fullDate[0].split('/');
      List<String>? time;
      if (fullDate.length > 1) {
        time = fullDate[1].split(':');
      }
      _missingDateToSend = DateTime.utc(
          int.parse(date[2]),
          int.parse(date[1]),
          int.parse(date[0]),
          time != null ? int.parse(time[0]) : 0,
          time != null ? int.parse(time[1]) : 0);
    } catch (e) {
      _controller.text = '';
      _missingDateToSend = null;
      return;
    }

    if (_missingDateToSend!.isAfter(DateTime.now())) {
      _missingDateToSend = DateTime.now();
    }
    String timeForController = widget.inputMastType != null &&
            widget.inputMastType == 'short'
        ? ''
        : ' ${_missingDateToSend?.hour.toString().padLeft(2, '0')}:${_missingDateToSend?.minute.toString().padLeft(2, '0')}';
    _controller.text =
        '${_missingDateToSend?.day.toString().padLeft(2, '0')}/${_missingDateToSend?.month.toString().padLeft(2, '0')}/${_missingDateToSend?.year}$timeForController';
  }

  void onSave(TextEditingValue? value) {
    missingDataPickerOutputCheck();
    widget.saveControllerData(
        {widget.name: _missingDateToSend?.toIso8601String() ?? ''});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: DatePickerFormField(
          title: 'Dodaj czas zaginięcia zwierzaka',
          minHeigh: 45,
          margin: const EdgeInsets.only(right: 1),
          expand: _expandController,
          expandHandlerFunction: expandHandler,
          controller: _controller,
          focusNode: _focusNode,
          inputMastType: widget.inputMastType,
          textInputFormatterList: widget.textInputFormatterList,
          validator: widget.validator,
          onSaved: onSave,
        ));
  }
}
