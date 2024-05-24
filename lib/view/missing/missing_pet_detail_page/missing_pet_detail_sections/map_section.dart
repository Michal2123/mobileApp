import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_detail_page/missing_pet_detail_sections/map_wit_pin_section.dart';

class MissingPetDetailMapSection extends StatefulWidget {
  const MissingPetDetailMapSection({super.key});

  @override
  State<MissingPetDetailMapSection> createState() =>
      _MissingPetDetailMapSectionState();
}

class _MissingPetDetailMapSectionState
    extends State<MissingPetDetailMapSection> {
  Coordinates _coordinates = Coordinates(
      x: DefaultMapCoordinates.x.value, y: DefaultMapCoordinates.y.value);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _coordinates =
          context.read<MissingDogService>().missingPetDetail?.coordinates ??
              Coordinates(
                  x: DefaultMapCoordinates.x.value,
                  y: DefaultMapCoordinates.y.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: MissingPetDetailMapWithPinSection(
        zoom: 15,
        diasbleFlags: false,
        coordinates: _coordinates,
      ),
    );
  }
}
