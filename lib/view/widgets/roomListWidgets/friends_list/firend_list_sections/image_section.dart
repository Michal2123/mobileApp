import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class FiendListImageSection extends StatelessWidget {
  const FiendListImageSection({super.key, required this.defaultRoom});
  final String? defaultRoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenMaxWitdhRatio.heightResize(context, 0.11),
      height: ScreenMaxWitdhRatio.heightResize(context, 0.11),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            width: 1,
            color: context
                    .read<MessangerConnectionService>()
                    .roomsList
                    .any((element) => element.id == defaultRoom)
                ? ColorConstant.defaultTextColor
                : ColorConstant.inkWellTextColor,
          )),
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: FlutterLogo(
          size: 45,
        ),
      ),
    );
  }
}
