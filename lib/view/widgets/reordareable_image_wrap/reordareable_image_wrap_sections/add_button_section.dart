import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class ReordarableImageAddButton extends StatelessWidget {
  const ReordarableImageAddButton({super.key, required this.getImageGallery});
  final Function() getImageGallery;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImageGallery,
      child: SizedBox(
          height: 124,
          width: 104,
          child: Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 35, top: 40, right: 35, bottom: 40),
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add_circle_rounded,
                      color: ColorConstant.activeButton,
                    ),
                  )))),
    );
  }
}
