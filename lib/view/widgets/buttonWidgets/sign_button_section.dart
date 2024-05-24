import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';

class SignFormButtonSection extends StatelessWidget {
  const SignFormButtonSection(
      {super.key, required this.submit, required this.tytle, this.isLoading});
  final Function submit;
  final String tytle;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.inkWellTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            ),
            onPressed: () => submit(),
            child: isLoading != null && isLoading == true
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: ColorConstant.buttonTextColor,
                    ),
                  )
                : Text(
                    tytle,
                    style: ButtonTextStyle(),
                  )));
  }
}
