import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ExerciseDetailTitleSection extends StatelessWidget {
  const ExerciseDetailTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.center,
        child: InputLabelText(
          text: context.read<ExercisesService>().exerciseDetail?.title ?? '',
          align: TextAlign.center,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
