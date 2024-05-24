import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class SwipeItalicRegularTextStyle extends TextStyle {
  SwipeItalicRegularTextStyle()
      : super(
          color: ColorConstant.swipePageTextColor,
          fontSize: 20,
          fontFamily: 'NunitoItalicRegular',
          fontWeight: FontWeight.w400,
        );

  SwipeItalicRegularTextStyle.detail()
      : super(
          color: ColorConstant.defaultTextColor,
          fontSize: 20,
          fontFamily: 'NunitoItalicRegular',
          fontWeight: FontWeight.w400,
        );
}
