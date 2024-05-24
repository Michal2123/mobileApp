import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/search_list_form/search_list/search_list_sections/input_field.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/search_list_form/search_list/search_list_sections/item_list.dart';

class SearchList extends StatelessWidget {
  const SearchList(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.list,
      required this.tagHandlerFunction,
      this.focusNode});

  final String hintText;
  final TextEditingController controller;
  final List<String> list;
  final Function(String) tagHandlerFunction;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeatchListInputFieldSection(
          hintText: hintText,
          controller: controller,
          focusNode: focusNode,
        ),
        SearchListItems(
          list: list,
          tagHandlerFunction: tagHandlerFunction,
        ),
      ],
    );
  }
}
