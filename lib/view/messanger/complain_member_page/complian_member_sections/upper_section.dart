import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ComplainMemberUpperSection extends StatelessWidget {
  const ComplainMemberUpperSection(
      {super.key, required this.searchBarTextController});
  final TextEditingController searchBarTextController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: InputLabelText(text: 'Zgłoś członka czatu'),
        ),
        CustomeSearchBar(
          searchBarTextController: searchBarTextController,
          clearController: () => searchBarTextController.clear(),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 5, left: 15, right: 15),
            child: InputLabelText(text: 'Członkowie'),
          ),
        )
      ],
    );
  }
}
