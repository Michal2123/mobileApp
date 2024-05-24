import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/delete_button_widget.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/elevation_button_widget.dart';

class SwipeBottomSection extends StatelessWidget {
  const SwipeBottomSection(
      {super.key,
      required this.isSwipeProfilesNotEmpty,
      required this.swipeMainController});
  final bool isSwipeProfilesNotEmpty;
  final SwipeController swipeMainController;

  @override
  Widget build(BuildContext context) {
    return isSwipeProfilesNotEmpty
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DeleteButton(
                    padding: const EdgeInsets.all(0),
                    iconSize: 30,
                    size: 50,
                    bgColor: Colors.pink.shade300,
                    onTap: () => swipeMainController.swipeLeft(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevationStyledButton(
                    icon: Icons.thumb_up_alt,
                    bgColor: Colors.green.shade400,
                    iconColor: ColorConstant.buttonTextColor,
                    iconSize: 30,
                    elevation: 0,
                    onPressed: () => swipeMainController.swipeRight(),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
