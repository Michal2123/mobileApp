import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/button_row_section.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/single_button_section.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';

class DetailProfileButtonSection extends StatelessWidget {
  const DetailProfileButtonSection({super.key, this.swipeController});
  final SwipeController? swipeController;
  @override
  Widget build(BuildContext context) {
    return swipeController != null
        ? DetailProfileButtonRowSection(
            swipeController: swipeController,
          )
        : const DetailProfileSingleButtonSection();
  }
}
