import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/elevation_button_widget.dart';

class BackArrowNavigation extends StatelessWidget {
  const BackArrowNavigation(
      {super.key, required this.view, this.navigatorFunction});
  final Function? navigatorFunction;
  final Widget view;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        view,
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: ElevationStyledButton(
                icon: Icons.arrow_back_ios_rounded,
                elevation: 3,
                bgColor: ColorConstant.floatingButtonActiveColor,
                iconColor: ColorConstant.defaultTextColor,
                padding: const EdgeInsets.all(15),
                onPressed: () {
                  if (navigatorFunction != null) {
                    navigatorFunction?.call();
                    return;
                  }
                  Navigator.pop(context);
                },
              )),
        ),
      ],
    );
  }
}
