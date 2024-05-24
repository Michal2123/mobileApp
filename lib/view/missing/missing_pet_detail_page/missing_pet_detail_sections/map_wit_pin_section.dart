import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/view/widgets/mapWidgets/map_point_to_latlng.dart';

class MissingPetDetailMapWithPinSection extends StatelessWidget {
  const MissingPetDetailMapWithPinSection(
      {super.key,
      required this.zoom,
      required this.diasbleFlags,
      required this.coordinates,
      this.overrideTap});
  final double zoom;
  final Function? overrideTap;
  final bool diasbleFlags;
  final Coordinates coordinates;

  @override
  Widget build(BuildContext context) {
    return PointToLatLngPage(
      latlng: LatLng(coordinates.x, coordinates.y),
      showUpBar: false,
      centerPosX: coordinates.x,
      centerPosY: coordinates.y,
      zoom: zoom,
      overrideTap: overrideTap,
      disableFlags: diasbleFlags,
    );
  }
}
