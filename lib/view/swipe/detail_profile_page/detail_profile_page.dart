import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/button_section.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/main_section.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class DetailProfile extends StatelessWidget {
  const DetailProfile(
      {super.key, required this.swipeProfileModel, this.swipeController});

  final SwipeProfileModel swipeProfileModel;
  final SwipeController? swipeController;

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      child: Stack(children: [
        DetailProfileMainSection(
          swipeProfileModel: swipeProfileModel,
        ),
        DetailProfileButtonSection(
          swipeController: swipeController,
        ),
      ]),
    );
  }
}
