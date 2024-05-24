import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/service/map_service.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_page.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_sections/announcement_section.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class MissingPetsAnnouncementListSection extends StatefulWidget {
  const MissingPetsAnnouncementListSection(
      {super.key,
      required this.controller,
      required this.missingPageTabs,
      required this.onLoading});
  final ScrollController controller;
  final MissingPageTabs missingPageTabs;
  final Function(bool) onLoading;

  @override
  State<MissingPetsAnnouncementListSection> createState() =>
      _MissingPetsAnnouncementListSectionState();
}

class _MissingPetsAnnouncementListSectionState
    extends State<MissingPetsAnnouncementListSection> {
  final ContextPopups _contextPopups = ContextPopups();
  bool _isLoading = false;

  @override
  void initState() {
    widget.controller.addListener(_scrollListener);
    super.initState();
  }

  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
    widget.onLoading(_isLoading);
  }

  void onSelect(String id) {
    if (widget.missingPageTabs == MissingPageTabs.myAnnouncementTab) {
      enterDetailPage(id,
          MaterialPageRoute(builder: (context) => const MissingPetDetail()));
    }
  }

  void enterDetailPage(String id, Route<dynamic> rout) {
    _contextPopups.loadingIndicator(context);
    context.read<MissingDogService>().missingPetDetail = null;
    context.read<MissingDogService>().getCurrentAdDetails(id).then((value) {
      Coordinates? coordinates =
          context.read<MissingDogService>().missingPetDetail?.coordinates;
      if (coordinates != null) {
        context.read<MapService>().latLng =
            LatLng(coordinates.y, coordinates.x);
      }

      Navigator.of(context).pop();
      Navigator.of(context).push(rout);
    }).catchError((error) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var announcmentList =
        widget.missingPageTabs == MissingPageTabs.announcementTab
            ? context.watch<MissingDogService>().missingDogList
            : context.watch<MissingDogService>().myMissingDogList;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: announcmentList.isNotEmpty
          ? RefreshIndicator(
              color: ColorConstant.inkWellTextColor,
              onRefresh: _refresh,
              child: ListView(
                controller: widget.controller,
                children: [
                  for (var announcement in announcmentList)
                    GestureDetector(
                        onTap: () => onSelect(announcement.id),
                        child: MissingPetsAnnouncementSection(
                          announcement: announcement,
                          missingPageTabs: widget.missingPageTabs,
                          enterDetailPage: enterDetailPage,
                        )),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Future<void> _scrollListener() async {
    if (widget.controller.position.pixels ==
            widget.controller.position.maxScrollExtent &&
        !_isLoading &&
        widget.missingPageTabs == MissingPageTabs.myAnnouncementTab) {
      loading();
      await context.read<MissingDogService>().getMoreAds();
      loading();
    }
  }

  Future<void> _refresh() async {
    if (widget.missingPageTabs == MissingPageTabs.myAnnouncementTab) {
      context.read<MissingDogService>().getAllCurrentAds(true);
    }
  }
}
