import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ExercisesCategoryItemTitleSection extends StatelessWidget {
  const ExercisesCategoryItemTitleSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 100,
      ),
      child: InputLabelText(
        overflow: TextOverflow.ellipsis,
        align: TextAlign.center,
        maxLines: 2,
        text: title,
      ),
    );
  }
}
