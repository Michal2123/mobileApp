import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ChatAppBarSection extends AppBar {
  final String roomName;
  final Function()? leaveRoom;
  final Function()? openMenu;
  ChatAppBarSection(
      {super.key, required this.roomName, this.leaveRoom, this.openMenu})
      : super(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: leaveRoom),
            titleSpacing: 0,
            title: GestureDetector(
              onTap: openMenu,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          width: 1,
                          color: ColorConstant.defaultTextColor,
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: FlutterLogo(
                        size: 25,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: InputLabelText(
                          overflow: TextOverflow.fade, text: roomName),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: ColorConstant.inputFillColor);
}
