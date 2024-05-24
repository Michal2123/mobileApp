import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';

class GroupChatMenuImageSection extends StatelessWidget {
  const GroupChatMenuImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
