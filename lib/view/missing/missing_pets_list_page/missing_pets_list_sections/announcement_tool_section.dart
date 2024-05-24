import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/delete_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_page.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class MissingPetsAnnouncementToolSection extends StatefulWidget {
  const MissingPetsAnnouncementToolSection(
      {super.key,
      required this.announcementId,
      required this.missingPageTabs,
      required this.enterDetailPage});
  final String announcementId;
  final MissingPageTabs missingPageTabs;
  final Function(String, Route) enterDetailPage;

  @override
  State<MissingPetsAnnouncementToolSection> createState() =>
      _MissingPetsAnnouncementToolSectionState();
}

class _MissingPetsAnnouncementToolSectionState
    extends State<MissingPetsAnnouncementToolSection> {
  final ContextPopups _contextPopups = ContextPopups();

  void onEdit(String id) {
    widget.enterDetailPage(
        id, MaterialPageRoute(builder: (context) => const MissingPetForm()));
  }

  void onRemove(String id) {
    _contextPopups
        .decisionPopup(context, 'Czy napewno chcesz usunąć \nto ogłoszenie?')
        .then((confirm) {
      if (confirm) {
        _contextPopups.loadingIndicator(context);
        context.read<MissingDogService>().deleteAd(id).then((_) {
          Navigator.of(context).pop();
        }).catchError((error) {
          Navigator.of(context).pop();
        });
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.missingPageTabs == MissingPageTabs.myAnnouncementTab
        ? SizedBox(
            height: ScreenMaxWitdhRatio.heightResize(context, 0.2),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => onEdit(widget.announcementId),
                          child: Icon(
                            Icons.edit,
                            size: 35,
                            color: ColorConstant.inkWellTextColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DeleteButton(
                          size: 30,
                          padding: const EdgeInsets.all(0),
                          onTap: () => onRemove(widget.announcementId),
                        ),
                      ),
                    ]),
              ),
            ),
          )
        : const SizedBox();
  }
}
