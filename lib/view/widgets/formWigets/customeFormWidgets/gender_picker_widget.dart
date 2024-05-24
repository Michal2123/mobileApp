import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker(
      {super.key, required this.genderPicker, this.gender = Gender.male});
  final Gender gender;
  final Function(Gender pickedGender) genderPicker;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => genderPicker(Gender.male),
          child: AnimatedContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: gender == Gender.male
                      ? ColorConstant.defaultTextColor
                      : Colors.transparent,
                  width: 1,
                )),
            duration: const Duration(milliseconds: 100),
            child: const Icon(
              Icons.male_rounded,
              size: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () => genderPicker(Gender.female),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: gender == Gender.female
                        ? ColorConstant.defaultTextColor
                        : Colors.transparent,
                    width: 1,
                  )),
              duration: const Duration(milliseconds: 100),
              child: const Icon(
                Icons.female_rounded,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
