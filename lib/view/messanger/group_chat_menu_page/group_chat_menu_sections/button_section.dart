import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class GroupChatMenuButtonSection extends StatelessWidget {
  const GroupChatMenuButtonSection({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
    this.color,
  });
  final IconData icon;
  final Function()? onTap;
  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Icon(
                icon,
                size: 50,
                color: color,
              ),
            ),
            SizedBox(
              height: 65,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InputLabelText(
                  align: TextAlign.center,
                  color: color,
                  text: title,
                ),
              ),
            )
          ],
        ));
  }
}
