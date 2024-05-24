import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/input_default.dart';

class SeatchListInputFieldSection extends StatelessWidget {
  const SeatchListInputFieldSection(
      {super.key,
      required this.hintText,
      required this.controller,
      this.focusNode});
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        children: [
          TextField(
            focusNode: focusNode,
            style: InputTextStyle(),
            decoration: InputDecoration(
                hintText: hintText,
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorConstant.inputFocusBorderColor),
                )),
            controller: controller,
          ),
          const Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(color: Colors.grey, Icons.search),
              )),
        ],
      ),
    );
  }
}
