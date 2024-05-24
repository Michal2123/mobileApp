import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class ExerciseDetailImageSection extends StatelessWidget {
  const ExerciseDetailImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstant.defaultTextColor),
            borderRadius: BorderRadius.circular(25)),
        child: const FlutterLogo(
          size: 350,
        ),
      ),
    );
  }
}
