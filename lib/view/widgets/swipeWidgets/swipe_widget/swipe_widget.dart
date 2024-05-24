import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/detailPageWidgets/multi_source_image.dart';
import 'package:flutter_mobile_app/view/widgets/swipeWidgets/swipe_widget/swipe_widget_sections/info_section.dart';

class SwipeWidget extends StatelessWidget {
  final String firstName;
  final String? imagePath;
  final List<SwipeProfileDogModel>? dogs;
  final GestureTapCallback onClickFunction;
  const SwipeWidget(
      {super.key,
      required this.firstName,
      this.imagePath,
      this.dogs,
      required this.onClickFunction});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(children: [
        Expanded(
          child: DetailProfileMultiSourceImage(
            imagePath: imagePath ?? '',
          ),
        ),
        GestureDetector(
          onTap: onClickFunction,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 125,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: ColorConstant.swipePhotoGradient)),
                ),
              ),
              SwipeWidgetInfoSection(
                firstName: firstName,
                dogs: dogs,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
