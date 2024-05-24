import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/map_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/mapWidgets/map_point_to_latlng.dart';

class MapForm extends StatefulWidget {
  const MapForm({
    super.key,
  });

  @override
  State<MapForm> createState() => _MissingPetFormMapSectionState();
}

class _MissingPetFormMapSectionState extends State<MapForm> {
  LatLng _latLng = const LatLng(0, 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _latLng = context.read<MapService>().latLng ?? const LatLng(0, 0);
  }

  void closeMap() {
    Navigator.pop(context);
    if (_latLng.latitude != 0 && _latLng.longitude != 0) {
      FocusManager.instance.primaryFocus!.unfocus();
      return;
    }
  }

  void saveLatLng(LatLng latlng) {
    setState(() {
      _latLng = latlng;
    });
    context.read<MapService>().latLng = latlng;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PointToLatLngPage(
        latlng: _latLng,
        saveLatLng: saveLatLng,
      ),
      Positioned(
          bottom: 125,
          right: 25,
          child: FloatingActionButton(
            backgroundColor: _latLng.latitude != 0 && _latLng.longitude != 0
                ? ColorConstant.floatingButtonActiveColor
                : ColorConstant.floatingButtonInactiveColor,
            heroTag: 'aproved',
            child: const Icon(Icons.check),
            onPressed: () => closeMap(),
          )),
    ]);
  }
}
