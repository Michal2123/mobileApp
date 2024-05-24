import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/pet_base_info_section.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/pet_extend_info_section.dart';
import 'package:flutter_mobile_app/view/widgets/detailPageWidgets/multi_source_image.dart';

class DetailProfilePetDetailsSection extends StatelessWidget {
  const DetailProfilePetDetailsSection(
      {super.key, required this.swipeProfileDogModel});
  final SwipeProfileDogModel swipeProfileDogModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  DetailProfileMultiSourceImage(
                    imagePath: swipeProfileDogModel.photo,
                  ),
                  DetailProfilePetBaseInfoSection(
                    swipeProfileDogModel: swipeProfileDogModel,
                  )
                ],
              ),
            ),
            DetaipProfilePetExtendInfoSection(
              description: swipeProfileDogModel.description,
            ),
          ],
        ),
      ),
    );
  }
}
