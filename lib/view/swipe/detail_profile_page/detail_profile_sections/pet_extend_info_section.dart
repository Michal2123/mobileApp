import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/tag_display_widget/tags_display_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/tag_text_widget.dart';

class DetaipProfilePetExtendInfoSection extends StatelessWidget {
  const DetaipProfilePetExtendInfoSection(
      {super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        description.isNotEmpty
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TagText(
                  text: description,
                ),
              )
            : const SizedBox(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5),
          child: TagsDisplay(
            expand: false,
            tags: ['lubi dzieci', 'piłeczka', 'kąpiele'],
            mockTags: [],
          ),
        )
      ],
    );
  }
}
