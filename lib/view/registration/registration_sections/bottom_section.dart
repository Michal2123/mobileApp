import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/login/login_page/login_page.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/inkwell_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class RegistrationBottomSection extends StatelessWidget {
  const RegistrationBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const InputLabelText(text: 'Masz już konto? '),
            InkWell(
              onTap: (() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Login()));
              }),
              child: const InkWellText(text: 'Zaluguj się'),
            )
          ],
        ),
      ),
    );
  }
}
