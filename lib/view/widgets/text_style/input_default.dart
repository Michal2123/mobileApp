import 'package:flutter/material.dart';

import 'package:flutter_mobile_app/utils/color_constant.dart';

class InputTextStyle extends TextStyle {
  InputTextStyle()
      : super(
          color: ColorConstant.defaultTextColor,
          fontSize: 17,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
        );
}
