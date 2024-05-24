import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/view/exercises/exercises_page/exercises_sections/category_list_section.dart';

class Exercises extends StatelessWidget {
  const Exercises({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        for (var category in context.watch<ExercisesService>().categoryList)
          ExercisesCategoryListSection(
            category: category,
          ),
      ],
    );
  }
}
