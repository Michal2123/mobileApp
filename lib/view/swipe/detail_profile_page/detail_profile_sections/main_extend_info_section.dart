import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/tag_display_widget/tags_display_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/tag_text_widget.dart';

class DetailProfileMainExtendInfoSection extends StatelessWidget {
  const DetailProfileMainExtendInfoSection(
      {super.key, this.description, this.tags});
  final String? description;
  final List<String>? tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TagText(
            text: description ?? '',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 15),
          child: TagsDisplay(
            expand: false,
            tags: tags ?? [],
            mockTags: const [],
          ),
        )
      ],
    );
  }
}
