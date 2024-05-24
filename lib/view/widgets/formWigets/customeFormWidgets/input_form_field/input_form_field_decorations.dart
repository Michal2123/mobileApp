import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/disabled_input.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_default.dart';

class InputFormFieldDecorations extends InputDecoration {
  final String title;
  final bool? enableTextField;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  InputFormFieldDecorations.standard(
      {required this.title, this.enableTextField, this.padding, this.radius})
      : super(
            isDense: true,
            hintText: title,
            hintStyle: enableTextField != null
                ? enableTextField
                    ? InputTextStyle()
                    : DisabledInputTextStyle()
                : DisabledInputTextStyle(),
            filled: true,
            fillColor: ColorConstant.inputFillColor,
            contentPadding: padding,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide: BorderSide(color: ColorConstant.inputBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide:
                  BorderSide(color: ColorConstant.inputFocusBorderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide:
                  BorderSide(color: ColorConstant.inputErrorBorderColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
                borderSide:
                    BorderSide(color: ColorConstant.inputFocusBorderColor)),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              borderSide: BorderSide(color: ColorConstant.inputBorderColor),
            ));
  InputFormFieldDecorations.simple(
      {this.enableTextField, this.padding, this.radius, required this.title})
      : super(
            isDense: true,
            hintText: title,
            hintStyle: InputTextStyle(),
            counterText: "",
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)));
}
