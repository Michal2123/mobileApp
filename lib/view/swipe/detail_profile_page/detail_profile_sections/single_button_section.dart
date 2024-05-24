import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class DetailProfileSingleButtonSection extends StatelessWidget {
  const DetailProfileSingleButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: ColorConstant.floatingButtonActiveColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15)),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: ColorConstant.defaultTextColor,
            ),
          )),
    );
  }
}
