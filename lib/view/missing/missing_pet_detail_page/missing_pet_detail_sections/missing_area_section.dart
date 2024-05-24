import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/info_card_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/map_wit_pin_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class MissingPetDetailMissingAreaSection extends StatelessWidget {
  const MissingPetDetailMissingAreaSection({super.key, required this.showMap});
  final Function showMap;

  String missingDateParser(String missingDate) {
    var date = DateTime.parse(missingDate).toString().substring(0, 16);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    var missingPetDetail = context.read<MissingDogService>().missingPetDetail;
    return missingPetDetail != null
        ? MissingPetDetailInfoCardSection(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const InputLabelText(
                      text: 'Miejsce i czas zaginięcia',
                      fontSize: 18,
                    ),
                    LabelText(
                        text:
                            '${missingPetDetail.coordinates.x.toStringAsFixed(4)}, ${missingPetDetail.coordinates.y.toStringAsFixed(4)}'),
                    LabelText(
                        text: missingDateParser(missingPetDetail.missingDate))
                  ],
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: MissingPetDetailMapWithPinSection(
                        zoom: 14,
                        diasbleFlags: true,
                        coordinates: missingPetDetail.coordinates,
                        overrideTap: () => showMap()),
                  ),
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
