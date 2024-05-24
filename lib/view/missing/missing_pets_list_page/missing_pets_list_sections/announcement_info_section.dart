import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/missing_models/missing_dog_preview_model.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class MissingPetsAnnouncementInfoSection extends StatelessWidget {
  const MissingPetsAnnouncementInfoSection(
      {super.key, required this.announcement});
  final MissingDogPreviewModel announcement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          announcement.name?.isNotEmpty == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: ScreenMaxWitdhRatio.getMaxWidth(context) * 0.45,
                    child: InputLabelText(
                      text: announcement.name ?? '',
                      fontSize: 24,
                    ),
                  ),
                )
              : const SizedBox(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: InputLabelText(
              text: 'Wa-wa',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: LabelText(
              text:
                  '${DateTime.parse(announcement.missingDate).hour}:${DateTime.parse(announcement.missingDate).minute.toString().padLeft(2, '0')}',
            ),
          ),
        ],
      ),
    );
  }
}
