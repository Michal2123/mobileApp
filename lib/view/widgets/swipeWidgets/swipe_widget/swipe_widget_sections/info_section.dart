import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/helper/mixins/sufix_age_helper_mixin.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/swipe_bold.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/swipe_italic_regular.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/swipe_regular.dart';

class SwipeWidgetInfoSection extends StatelessWidget with SufixAgeHelper {
  const SwipeWidgetInfoSection({super.key, required this.firstName, this.dogs});
  final String firstName;
  final List<SwipeProfileDogModel>? dogs;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  firstName,
                  style: SwipeBoldTextStyle(),
                ),
                Row(children: [
                  Text(
                    dogs?.isNotEmpty == true ? '${dogs?.first.name} ' : '',
                    style: SwipeBoldTextStyle(),
                  ),
                  Text(
                    dogs?.isNotEmpty == true
                        ? ' ${dogs?.first.age} ${ageCheck(dogs?.first.age)}'
                        : '',
                    style: SwipeRegularTextStyle(),
                  ),
                ]),
                Text(
                  dogs?.isNotEmpty == true ? '${dogs?.first.breed}' : '',
                  style: SwipeItalicRegularTextStyle(),
                ),
              ],
            )),
      ),
    );
  }
}
