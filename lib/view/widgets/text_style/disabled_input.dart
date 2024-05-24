import 'package:flutter/material.dart';

import 'package:flutter_mobile_app/utils/color_constant.dart';

class DisabledInputTextStyle extends TextStyle {
  DisabledInputTextStyle()
      : super(
          color: ColorConstant.floatingButtonInactiveColor,
          fontSize: 17,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
        );
}
