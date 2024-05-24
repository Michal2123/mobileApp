
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/base_info_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/contact_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/description_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/image_carousel_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/missing_area_section.dart';

class MissingPetDetailInfoList extends StatelessWidget {
  const MissingPetDetailInfoList({
    super.key,
    required this.showMap,
  });
  final Function showMap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 50),
      children: [
        const MissingPetDetailImageCarouselSection(),
        MissingPetDetailBaseInfoSection(),
        MissingPetDetailMissingAreaSection(
          showMap: showMap,
        ),
        const MissingPetDetailDescriptionSection(),
        const MissingPetContactSection()
      ],
    );
  }
}
