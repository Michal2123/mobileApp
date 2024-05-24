import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class SingleChatMenuUpperSection extends StatelessWidget {
  const SingleChatMenuUpperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all(
                width: 1,
                color: ColorConstant.defaultTextColor,
              )),
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: FlutterLogo(
              size: 100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InputLabelText(
            text: context
                .read<MessangerConnectionService>()
                .currentRoomOpen!
                .roomName,
            fontSize: 28,
          ),
        )
      ],
    );
  }
}
