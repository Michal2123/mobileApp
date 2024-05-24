import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/tag_display_widget/tag_display_sections/tag_item_section.dart';

class TagsDisplay extends StatelessWidget {
  const TagsDisplay(
      {super.key,
      required this.tags,
      required this.mockTags,
      required this.expand,
      this.tagHandlerFunction});

  final bool expand;
  final List<String> tags;
  final List<String> mockTags;
  final Function(String)? tagHandlerFunction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: <Widget>[
        for (var item in expand ? mockTags : tags)
          expand
              ? GestureDetector(
                  onTap: () {
                    if (tagHandlerFunction != null && expand) {
                      tagHandlerFunction!(item);
                    }
                  },
                  child: TagsDisplayItemSection(
                    expand: expand,
                    tags: tags,
                    item: item,
                  ))
              : TagsDisplayItemSection(
                  expand: expand,
                  tags: tags,
                  item: item,
                ),
      ],
    );
  }
}
