import 'package:flutter/material.dart';

import 'package:flutter_mobile_app/utils/color_constant.dart';

class InputSemiBoldTextStyle extends TextStyle {
  InputSemiBoldTextStyle()
      : super(
          color: ColorConstant.defaultTextColor,
          fontSize: 17,
          fontFamily: 'NunitoSemiBold',
          fontWeight: FontWeight.w600,
        );
}
