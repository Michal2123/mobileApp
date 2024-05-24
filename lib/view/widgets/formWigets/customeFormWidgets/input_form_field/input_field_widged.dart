import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/input_form_field/input_form_field_decorations.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/disabled_input.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_default.dart';

class CustomeInputField extends TextFormField {
  final bool enableTextField;
  final String title;
  final String name;
  final bool style;
  final EdgeInsetsGeometry padding;
  final double radius;
  CustomeInputField(
      {super.key,
      this.enableTextField = true,
      required this.title,
      required this.name,
      this.style = true,
      this.radius = 15,
      this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      required super.obscureText,
      required super.controller,
      required super.keyboardType,
      super.enabled = true,
      super.textAlign,
      super.maxLines,
      super.minLines = 1,
      super.onChanged,
      super.onTap,
      super.maxLength,
      super.inputFormatters,
      super.focusNode,
      super.validator,
      super.onSaved})
      : super(
          style: enableTextField ? InputTextStyle() : DisabledInputTextStyle(),
          decoration: style
              ? InputFormFieldDecorations.standard(
                  title: title,
                  enableTextField: enableTextField,
                  padding: padding,
                  radius: radius)
              : InputFormFieldDecorations.simple(title: title),
        );
}
