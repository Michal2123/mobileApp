import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/exercises/exercise_detail_page/exercise_detail_sections/description_section.dart';
import 'package:flutter_mobile_app/view/exercises/exercise_detail_page/exercise_detail_sections/image_section.dart';
import 'package:flutter_mobile_app/view/exercises/exercise_detail_page/exercise_detail_sections/title_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class ExerciseDetail extends StatelessWidget {
  const ExerciseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      child: BackArrowNavigation(
        view: ListView(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          children: const [
            ExerciseDetailTitleSection(),
            ExerciseDetailImageSection(),
            ExerciseDetailDescriptionSection()
          ],
        ),
      ),
    );
  }
}
