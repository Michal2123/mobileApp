import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/exercise_models/exercise_model.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/view/exercises/exercise_detail_page/exercise_detail_page.dart';
import 'package:flutter_mobile_app/view/exercises/exercises_page/exercises_sections/category_item_image_section.dart';
import 'package:flutter_mobile_app/view/exercises/exercises_page/exercises_sections/category_item_title_section.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class ExercisesCategoryItemSection extends StatelessWidget {
  const ExercisesCategoryItemSection({super.key, required this.exercise});
  final ExerciseModel exercise;

  void onTap(BuildContext context) {
    context
        .read<ExercisesService>()
        .getExerciseDetail(exercise.id)
        .then((_) => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ExerciseDetail(),
            settings: RouteSettings(name: MainPages.excercisePage.name))))
        .onError((e, s) => {
              ContextPopups().alertPopup(context,
                  'Nie udało się pobrać danych o ćwiczeniu.\nSprawdź połączenie z internetem lub spróbuj ponownie później')
            });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Column(
          children: [
            ExercisesCategoryItemImageSection(
              image: exercise.image,
            ),
            ExercisesCategoryItemTitleSection(
              title: exercise.title,
            ),
          ],
        ),
      ),
    );
  }
}
