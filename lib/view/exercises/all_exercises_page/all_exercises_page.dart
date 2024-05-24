import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/exercises/all_exercises_page/all_exercises_sections/list_section.dart';
import 'package:flutter_mobile_app/view/exercises/all_exercises_page/all_exercises_sections/search_section.dart';
import 'package:flutter_mobile_app/view/exercises/all_exercises_page/all_exercises_sections/top_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class AllExercises extends StatelessWidget {
  const AllExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      unfocusFunction: FocusManager.instance.primaryFocus!.unfocus,
      child: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            AllExercisesTopSection(),
            AllExercisesSearchSection(),
            AllExercisesListSection(),
          ],
        ),
      ),
    );
  }
}
