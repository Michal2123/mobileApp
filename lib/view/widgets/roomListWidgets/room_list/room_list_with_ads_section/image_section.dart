import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class RoomListWithAdsImageSection extends StatelessWidget {
  const RoomListWithAdsImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(
            width: 1,
            color: ColorConstant.defaultTextColor,
          )),
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: FlutterLogo(
          size: 45,
        ),
      ),
    );
  }
}
