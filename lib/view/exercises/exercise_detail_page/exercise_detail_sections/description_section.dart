import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_default.dart';

class ExerciseDetailDescriptionSection extends StatelessWidget {
  const ExerciseDetailDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          context.read<ExercisesService>().exerciseDetail?.description ?? '',
          style: InputTextStyle(),
        ));
  }
}
