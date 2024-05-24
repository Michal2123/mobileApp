import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';

class MissingPetDetailMessageButtonSection extends StatelessWidget {
  const MissingPetDetailMessageButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Row(
          children: [
            Text(
              'Wiadomość',
              style: ButtonTextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.mail_outline_rounded,
                size: 30,
                color: ColorConstant.buttonTextColor,
              ),
            )
          ],
        ));
  }
}
