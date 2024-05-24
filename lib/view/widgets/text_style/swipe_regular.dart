import 'package:flutter/material.dart';

import 'package:flutter_mobile_app/utils/color_constant.dart';

class SwipeRegularTextStyle extends TextStyle {
  SwipeRegularTextStyle()
      : super(
          color: ColorConstant.swipePageTextColor,
          fontSize: 20,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
        );

  SwipeRegularTextStyle.detail()
      : super(
          color: ColorConstant.defaultTextColor,
          fontSize: 20,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
        );
}
