import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class SearchListItems extends StatelessWidget {
  const SearchListItems(
      {super.key, required this.list, required this.tagHandlerFunction});
  final List<String> list;
  final Function(String) tagHandlerFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var item in list)
            GestureDetector(
              onTap: () {
                tagHandlerFunction(item);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: LabelText(text: item),
              ),
            )
        ],
      ),
    );
  }
}
