import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ContextlessPopups {
  singoutPopup() {
    showDialog(
        barrierDismissible: false,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: const Align(
                alignment: Alignment.center,
                child: InputLabelText(
                  maxLines: 2,
                  text: 'Sesja wygasła, zaloguj się ponownie.',
                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 25),
            backgroundColor: ColorConstant.backgroundScaffoldColor,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      navigatorKey.currentState!.pushNamed('login');
                    },
                    child: Text(
                      'ok',
                      style: ButtonTextStyle(),
                    )),
              ),
            ],
          );
        });
  }
}
