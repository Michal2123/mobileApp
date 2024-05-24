import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class PasswordResetTopSection extends StatelessWidget {
  const PasswordResetTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: FlutterLogo(
              size: 120,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 30, right: 15),
            child: LabelText(text: "Hasło wyleciało z głowy?"),
          ),
        )
      ],
    );
  }
}
