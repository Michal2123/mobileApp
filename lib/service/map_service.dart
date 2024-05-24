import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

class MapService with ChangeNotifier, DiagnosticableTreeMixin {
  LatLng? _latLng;
  LatLng? get latLng => _latLng;
  set latLng(LatLng? latLng) {
    _latLng = latLng;
    notifyListeners();
  }

  static const String latLngPropName = "latLng";

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('latLng', latLng));
  }
}
