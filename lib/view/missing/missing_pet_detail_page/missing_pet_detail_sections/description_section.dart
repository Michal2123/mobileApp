import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/missing_models/missing_dog_detail_model.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/info_card_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_default.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_semibold.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class MissingPetDetailDescriptionSection extends StatefulWidget {
  const MissingPetDetailDescriptionSection({super.key});

  @override
  State<MissingPetDetailDescriptionSection> createState() =>
      _MissingPetDetailDescriptionSectionState();
}

class _MissingPetDetailDescriptionSectionState
    extends State<MissingPetDetailDescriptionSection> {
  late MissingDogDetailModel? _missingPetDetail;
  late String _description;
  late int _reward;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _missingPetDetail = context.read<MissingDogService>().missingPetDetail;
      _description = _missingPetDetail?.description ?? '';
      _reward = _missingPetDetail?.reward ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _missingPetDetail != null
        ? MissingPetDetailInfoCardSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _description.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const InputLabelText(
                            text: 'Opis',
                            fontSize: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              _description,
                              style: InputTextStyle(),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
                _reward > 0
                    ? Row(
                        children: [
                          Text(
                            'Nagroda:',
                            style: InputSemiBoldTextStyle(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '$_reward zł',
                              style: InputSemiBoldTextStyle(),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          )
        : const SizedBox();
  }
}
