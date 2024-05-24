import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/detailPageWidgets/multi_source_image.dart';
import 'package:flutter_mobile_app/view/widgets/reordareable_image_wrap/reordareable_image_wrap_sections/add_button_section.dart';
import 'package:flutter_mobile_app/view/widgets/reordareable_image_wrap/reordareable_image_wrap_sections/delete_button_section.dart';
import 'package:reorderables/reorderables.dart';

class ReordareableImageWrapGrid extends StatelessWidget {
  const ReordareableImageWrapGrid(
      {super.key,
      required this.images,
      required this.getImageGallery,
      required this.onReorder,
      required this.onDelete,
      required this.controller});

  final List<Map<String, dynamic>> images;
  final Function() getImageGallery;
  final Function(int oldIndex, int newIndex) onReorder;
  final Function(Map<String, dynamic> image) onDelete;
  final ScrollController controller;

  Widget buildDraggableFeedback(
      BuildContext context, BoxConstraints constraints, Widget child) {
    return Transform(
      transform: Matrix4.rotationZ(0),
      alignment: FractionalOffset.topLeft,
      child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: ConstrainedBox(constraints: constraints, child: child)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
      controller: controller,
      buildDraggableFeedback: buildDraggableFeedback,
      spacing: 8.5,
      runSpacing: 6.0,
      padding: const EdgeInsets.all(8),
      footer: SizedBox(
        height: 124,
        width: 104,
        child: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: DottedBorder(
              color: ColorConstant.dottedBorderColor,
              strokeWidth: 2,
              dashPattern: const [7, 10],
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              child: ReordarableImageAddButton(
                getImageGallery: getImageGallery,
              )),
        ),
      ),
      onReorder: onReorder,
      children: [
        for (var image in images)
          SizedBox(
              height: 125.00,
              width: 115.00,
              child: Stack(alignment: Alignment.bottomRight, children: [
                DetailProfileMultiSourceImage(
                  imagePath: image['value'],
                ),
                ReordareableImageDeleteButton(
                  onDelete: onDelete,
                  image: image,
                )
              ])),
      ],
    );
  }
}
