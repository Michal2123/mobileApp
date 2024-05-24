import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class SignFormTopSection extends StatelessWidget {
  const SignFormTopSection({super.key, required this.tytle, this.hideTytle});
  final String tytle;
  final bool? hideTytle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
      ),
      child: Column(
        children: [
          const SizedBox(
            width: 120,
            child: FlutterLogo(
              size: 150,
            ),
          ),
          hideTytle != null && hideTytle == true
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: LabelText(text: tytle),
                ),
        ],
      ),
    );
  }
}
