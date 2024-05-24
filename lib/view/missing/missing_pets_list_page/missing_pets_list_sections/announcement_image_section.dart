import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class MissingPetsAnnouncementImageSection extends StatelessWidget {
  const MissingPetsAnnouncementImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: ScreenMaxWitdhRatio.heightResize(context, 0.18),
        height: ScreenMaxWitdhRatio.heightResize(context, 0.18),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
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
      ),
    );
  }
}
