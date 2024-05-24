import 'package:flutter/material.dart';

import 'package:flutter_mobile_app/utils/color_constant.dart';

class ButtonTextStyle extends TextStyle {
  ButtonTextStyle({super.fontSize = 24, super.fontWeight = FontWeight.w600})
      : super(
          color: ColorConstant.buttonTextColor,
          fontFamily: 'Nunito',
        );
}
