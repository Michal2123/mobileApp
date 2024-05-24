import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/missing_models/missing_dog_preview_model.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_sections/announcement_image_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_sections/announcement_info_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_sections/announcement_tool_section.dart';

class MissingPetsAnnouncementSection extends StatelessWidget {
  const MissingPetsAnnouncementSection(
      {super.key,
      required this.missingPageTabs,
      required this.announcement,
      required this.enterDetailPage});
  final MissingPageTabs missingPageTabs;
  final MissingDogPreviewModel announcement;
  final Function(String, Route) enterDetailPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: Stack(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [
              const MissingPetsAnnouncementImageSection(),
              MissingPetsAnnouncementInfoSection(
                announcement: announcement,
              )
            ]),
          ),
          MissingPetsAnnouncementToolSection(
            announcementId: announcement.id,
            missingPageTabs: missingPageTabs,
            enterDetailPage: enterDetailPage,
          )
        ]),
      ),
    );
  }
}
