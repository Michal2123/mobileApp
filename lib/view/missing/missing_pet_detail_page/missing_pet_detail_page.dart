import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/info_list_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/map_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class MissingPetDetail extends StatefulWidget {
  const MissingPetDetail({
    super.key,
  });

  @override
  State<MissingPetDetail> createState() => _MissingPetDetailState();
}

class _MissingPetDetailState extends State<MissingPetDetail> {
  bool _isMapOpen = false;

  void showMap() {
    setState(() {
      _isMapOpen = !_isMapOpen;
    });
  }

  void toggleMap() {
    if (_isMapOpen) {
      showMap();
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      child: BackArrowNavigation(
        navigatorFunction: () => toggleMap(),
        view: _isMapOpen
            ? const MissingPetDetailMapSection()
            : MissingPetDetailInfoList(
                showMap: showMap,
              ),
      ),
    );
  }
}
