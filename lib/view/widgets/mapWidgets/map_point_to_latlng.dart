import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class PointToLatLngPage extends StatefulWidget {
  const PointToLatLngPage(
      {super.key,
      this.saveLatLng,
      this.overrideTap,
      required this.latlng,
      this.showUpBar = true,
      this.centerPosX = 52.23,
      this.centerPosY = 21.01,
      this.zoom = 15,
      this.disableFlags = false});

  final Function(LatLng latLng)? saveLatLng;
  final Function? overrideTap;
  final LatLng latlng;
  final bool showUpBar;
  final double centerPosX;
  final double centerPosY;
  final double zoom;
  final bool disableFlags;

  static const String route = 'point_to_latlng';

  @override
  State<PointToLatLngPage> createState() {
    return _PointToLatlngPage();
  }
}

class _PointToLatlngPage extends State<PointToLatLngPage> {
  final MapController _mapController = MapController();
  LatLng _latLng = const LatLng(52.23, 21.01);

  @override
  void initState() {
    _latLng = widget.latlng;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _latLng = widget.latlng;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _handleTap(dynamic tapPosition, LatLng latlng) {
    setState(() {
      _latLng = latlng;
      if (widget.saveLatLng != null) {
        widget.saveLatLng!(latlng);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            interactionOptions: InteractionOptions(
              flags: widget.disableFlags
                  ? InteractiveFlag.none
                  : InteractiveFlag.all,
            ),
            onTap: (tapPosition, point) {
              if (widget.overrideTap != null) {
                widget.overrideTap!();
                return;
              }
              _handleTap(tapPosition, point);
            },
            initialZoom: widget.zoom,
            maxZoom: 19,
            minZoom: 3,
            initialCenter: LatLng(widget.centerPosX, widget.centerPosY),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    point: _latLng,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 45),
                      child: Icon(
                        Icons.location_pin,
                        size: 50,
                        color: ColorConstant.inkWellTextColor,
                      ),
                    ))
              ],
            )
          ],
        ),
        widget.showUpBar
            ? Container(
                color: Colors.white,
                height: 100,
                child: const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 65.0),
                      child: LabelText(text: 'Postaw znacznik na mapie'),
                    ),
                  ],
                )))
            : const SizedBox(),
      ],
    );
  }

  double getPointX(BuildContext context) {
    return MediaQuery.of(context).size.width / 2;
  }
}
