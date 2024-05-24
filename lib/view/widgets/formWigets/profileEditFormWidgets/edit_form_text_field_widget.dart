import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/helper/mixins/sufix_age_helper_mixin.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/input_form_field/input_field_widged.dart';

class ProfileEditFormTextField extends StatefulWidget {
  const ProfileEditFormTextField(
      {super.key,
      required this.title,
      required this.name,
      this.textInputFormatterList,
      this.obscureText,
      required this.textInputType,
      required this.saveControllerData,
      required this.controllerValue,
      this.validator,
      this.onTap});

  final String title;
  final String name;
  final String controllerValue;
  final bool? obscureText;
  final List<TextInputFormatter>? textInputFormatterList;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final Function()? onTap;
  final Function(Map<String, String>) saveControllerData;

  @override
  State<ProfileEditFormTextField> createState() =>
      _MissingPetFormTextFieldSectionState();
}

class _MissingPetFormTextFieldSectionState
    extends State<ProfileEditFormTextField> with SufixAgeHelper {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.controllerValue;
    _node.addListener(ageSufix);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.clear();
    _node.dispose();
  }

  void onSaved(String? value) {
    widget.saveControllerData({
      widget.name: value ?? '',
    });
  }

  void ageSufix() {
    if (widget.name == 'age' && _controller.text.isNotEmpty) {
      var value = ageCheck(int.parse(_controller.text));
      _controller.text = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CustomeInputField(
          focusNode: _node,
          title: widget.title,
          name: widget.name,
          onTap: () => _controller.clear(),
          obscureText: widget.obscureText ?? false,
          controller: _controller,
          validator: widget.validator,
          onSaved: onSaved,
          keyboardType: widget.textInputType,
          inputFormatters: widget.textInputFormatterList),
    );
  }
}
