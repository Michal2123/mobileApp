import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/exercises/exercises_page/exercises_page.dart';

class AllExercisesListSection extends StatelessWidget {
  const AllExercisesListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SizedBox(width: double.infinity, child: Exercises()),
    );
  }
}
