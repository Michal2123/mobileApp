import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/delete_button_widget.dart';

class ReordareableImageDeleteButton extends StatelessWidget {
  const ReordareableImageDeleteButton(
      {super.key, required this.onDelete, required this.image});
  final Function(Map<String, dynamic> image) onDelete;
  final Map<String, dynamic> image;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: DeleteButton(
          elevation: 0,
          iconSize: 15,
          size: 20,
          padding: const EdgeInsets.all(0),
          onTap: () => onDelete(image),
        ));
  }
}
