import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class AllExercisesTopSection extends StatelessWidget {
  const AllExercisesTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: InputLabelText(text: 'Ćwiczenia'),
    );
  }
}
