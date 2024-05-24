import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/announcment_service_model.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class AnnouncmentListSection extends StatelessWidget {
  const AnnouncmentListSection(
      {super.key,
      required this.announcmentListToShow,
      required this.scrollController,
      required this.filtersList});
  final List<AnnouncmentServiceModel> announcmentListToShow;
  final ScrollController scrollController;
  final List<int> filtersList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(controller: scrollController, children: [
        for (var announcment in announcmentListToShow)
          filtersList.contains(announcment.type) || filtersList.isEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 7,
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            const FlutterLogo(
                              size: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InputLabelText(
                                    text: announcment.title,
                                    fontSize: 24,
                                  ),
                                  LabelText(
                                    text: announcment.describe,
                                  ),
                                  LabelText(text: announcment.adress),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 30,
                                        color: ColorConstant.activeButton,
                                      ),
                                      LabelText(
                                          text: announcment.score.toString()),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                )
              : const SizedBox()
      ]),
    );
  }
}
