import 'package:flutter/material.dart';

import 'package:flutter_mobile_app/view/widgets/buttonWidgets/delete_button_widget.dart';

class SearchBarSufixButtonSectin extends StatelessWidget {
  const SearchBarSufixButtonSectin({super.key, required this.clearController});
  final Function()? clearController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: DeleteButton(
            elevation: 0,
            iconSize: 15,
            size: 20,
            onTap: clearController,
            padding: const EdgeInsets.all(0),
          )),
    );
  }
}
