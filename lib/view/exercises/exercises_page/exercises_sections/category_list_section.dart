import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/exercise_models/exercise_model.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/view/exercises/exercises_page/exercises_sections/category_item_section.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ExercisesCategoryListSection extends StatelessWidget {
  const ExercisesCategoryListSection({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabelText(
          text: category.value,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: ScreenMaxWitdhRatio.heightResize(context, 0.215),
            maxHeight: ScreenMaxWitdhRatio.heightResize(context, 0.25),
          ),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              for (var element
                  in context.read<ExercisesService>().exercisesList)
                if (element.category.key == category.key)
                  ExercisesCategoryItemSection(
                    exercise: element,
                  )
            ],
          ),
        )
      ],
    );
  }
}
