import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/mixins/sufix_age_helper_mixin.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/info_card_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class MissingPetDetailBaseInfoSection extends StatelessWidget
    with SufixAgeHelper {
  MissingPetDetailBaseInfoSection({super.key});

  final List<String> _breedMock = [
    'Akita',
    'Akita amerykańska',
    'Basenji',
    'Beagle',
    'Cane corso',
    'Golden retriever',
    'Jack russell terrier',
  ];

  @override
  Widget build(BuildContext context) {
    var missingPetDetails = context.read<MissingDogService>().missingPetDetail;
    return missingPetDetails != null
        ? MissingPetDetailInfoCardSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InputLabelText(
                      text: missingPetDetails.name,
                      fontSize: 24,
                    ),
                    Icon(
                      missingPetDetails.sex == Gender.male
                          ? Icons.male_rounded
                          : Icons.female_rounded,
                      size: 30,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: LabelText(text: _breedMock[missingPetDetails.breed]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: LabelText(text: ageCheck(missingPetDetails.age)),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
