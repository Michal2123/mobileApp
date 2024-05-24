import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/tag_display_widget/tags_display_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class TagPickerField extends StatelessWidget {
  const TagPickerField(
      {super.key,
      required this.expand,
      required this.tagList,
      required this.selectedTagList,
      required this.tagHandlerFunction,
      required this.title});
  final bool expand;
  final List<String> tagList;
  final List<String> selectedTagList;
  final Function(String) tagHandlerFunction;
  final String title;
  @override
  Widget build(BuildContext context) {
    return selectedTagList.isNotEmpty || expand
        ? TagsDisplay(
            expand: expand,
            mockTags: tagList,
            tags: selectedTagList,
            tagHandlerFunction: tagHandlerFunction,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            child: LabelText(text: title),
          );
  }
}
