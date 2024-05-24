import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/helper/mixins/sufix_age_helper_mixin.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/swipe_italic_regular.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class DetailProfilePetBaseInfoSection extends StatelessWidget
    with SufixAgeHelper {
  const DetailProfilePetBaseInfoSection(
      {super.key, required this.swipeProfileDogModel});
  final SwipeProfileDogModel swipeProfileDogModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.4),
              child: InputLabelText(
                overflow: TextOverflow.ellipsis,
                text: swipeProfileDogModel.name,
                fontSize: 24,
              ),
            ),
            Icon(
              swipeProfileDogModel.sex == Gender.male
                  ? Icons.male_rounded
                  : Icons.female_rounded,
              size: 30,
            )
          ],
        ),
        Text(
          swipeProfileDogModel.breed.toString(),
          style: SwipeItalicRegularTextStyle.detail(),
        ),
        Text(
          '${swipeProfileDogModel.age} ${ageCheck(swipeProfileDogModel.age)}',
          style: SwipeItalicRegularTextStyle.detail(),
        ),
      ],
    );
  }
}
