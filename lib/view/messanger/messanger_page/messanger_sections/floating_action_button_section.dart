import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/messanger/creating_chat_page/creating_chat_page.dart';

class FloatingActionButtonSection extends StatelessWidget {
  const FloatingActionButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: Colors.white,
      elevation: 5,
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const CreatingChat())),
      child: Icon(
        Icons.edit_document,
        size: 30,
        color: ColorConstant.activeButton,
      ),
    );
  }
}
