import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';

class CheckBoxPopupButtonSection extends StatelessWidget {
  const CheckBoxPopupButtonSection(
      {super.key, required this.filterSubmitFunction});
  final GestureTapCallback filterSubmitFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
                MediaQuery.sizeOf(context).width > 400
                    ? 400
                    : MediaQuery.sizeOf(context).width,
                30),
          ),
          onPressed: filterSubmitFunction,
          child: Text(
            'Zastosuj',
            style: ButtonTextStyle(),
          )),
    );
  }
}
