import 'package:flutter/material.dart';

import 'package:flutter_mobile_app/utils/color_constant.dart';

class SwipeBoldTextStyle extends TextStyle {
  SwipeBoldTextStyle()
      : super(
          color: ColorConstant.swipePageTextColor,
          fontSize: 24,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
        );
}
