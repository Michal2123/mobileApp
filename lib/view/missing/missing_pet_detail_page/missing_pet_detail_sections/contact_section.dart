import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/info_card_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/message_button_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class MissingPetContactSection extends StatelessWidget {
  const MissingPetContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    var missingPetDetail = context.read<MissingDogService>().missingPetDetail;
    return missingPetDetail != null
        ? MissingPetDetailInfoCardSection(
            child: Row(
              mainAxisAlignment:
                  missingPetDetail.contactInfo?.isNotEmpty == true
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
              children: [
                missingPetDetail.contactInfo?.isNotEmpty == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const InputLabelText(text: 'Kontakt'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child:
                                LabelText(text: missingPetDetail.contactInfo!),
                          )
                        ],
                      )
                    : const SizedBox(),
                const MissingPetDetailMessageButtonSection(),
              ],
            ),
          )
        : const SizedBox();
  }
}
