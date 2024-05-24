import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_sections/main_card_section.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_sections/main_top_section.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class SwipeMainSection extends StatelessWidget {
  const SwipeMainSection({super.key, required this.swipeMainController});
  final SwipeController swipeMainController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SwipeMainTopSection(),
          SwipeMainCardSection(
            swipeMainController: swipeMainController,
          ),
          SizedBox(
            height: ScreenMaxWitdhRatio.heightResize(context, 0.05),
          )
        ],
      ),
    );
  }
}
