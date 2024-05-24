import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/swipe_profile_service.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_sections/bottom_section.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class SwipeController {
  late Function swipeLeft;
  late Function swipeRight;
}

class Swipe extends StatelessWidget {
  Swipe({super.key});

  final SwipeController _swipeController = SwipeController();

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      child: Stack(children: [
        SwipeMainSection(
          swipeMainController: _swipeController,
        ),
        SwipeBottomSection(
          isSwipeProfilesNotEmpty:
              context.watch<SwipeProfileService>().swipeProfiles.isNotEmpty,
          swipeMainController: _swipeController,
        ),
      ]),
    );
  }
}
