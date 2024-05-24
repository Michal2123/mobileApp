import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/delete_button_widget.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/elevation_button_widget.dart';

class DetailProfileButtonRowSection extends StatelessWidget {
  const DetailProfileButtonRowSection({super.key, this.swipeController});
  final SwipeController? swipeController;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DeleteButton(
                padding: const EdgeInsets.all(0),
                iconSize: 30,
                size: 50,
                bgColor: ColorConstant.swipeDislikeButtonColor,
                onTap: () {
                  swipeController?.swipeLeft();
                  Navigator.of(context).pop();
                },
              ),
              ElevationStyledButton(
                icon: Icons.thumb_up_alt,
                bgColor: ColorConstant.swipeLikeButtonColor,
                iconColor: ColorConstant.buttonTextColor,
                iconSize: 30,
                elevation: 0,
                onPressed: () {
                  swipeController?.swipeRight();
                  Navigator.of(context).pop();
                },
              ),
              ElevationStyledButton(
                icon: Icons.arrow_back_ios_rounded,
                elevation: 4,
                bgColor: ColorConstant.floatingButtonActiveColor,
                iconColor: ColorConstant.defaultTextColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
