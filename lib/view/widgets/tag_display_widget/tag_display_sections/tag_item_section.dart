import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/tag_text_widget.dart';

class TagsDisplayItemSection extends StatelessWidget {
  const TagsDisplayItemSection(
      {super.key,
      required this.expand,
      required this.tags,
      required this.item});
  final bool expand;
  final List<String> tags;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          color: expand && tags.contains(item)
              ? ColorConstant.inkWellTextColor
              : null,
          border: Border.all(
            color: expand && tags.contains(item)
                ? ColorConstant.backgroundScaffoldColor
                : ColorConstant.defaultTextColor,
            width: 1.00,
          ),
        ),
        child: TagText(
          text: item,
          color: expand && tags.contains(item)
              ? ColorConstant.backgroundScaffoldColor
              : ColorConstant.defaultTextColor,
        ));
  }
}
