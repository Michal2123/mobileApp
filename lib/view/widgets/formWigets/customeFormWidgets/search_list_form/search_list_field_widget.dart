import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/search_list_form/search_list/search_list_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/label_text_widget.dart';

class SearchListField extends StatefulWidget {
  const SearchListField(
      {super.key,
      required this.showSearchBreed,
      required this.controller,
      required this.selectBreed,
      required this.itemsList,
      this.searchFocusNode});

  final bool showSearchBreed;
  final TextEditingController controller;
  final Function(String) selectBreed;
  final List<String> itemsList;
  final FocusNode? searchFocusNode;

  @override
  State<SearchListField> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<SearchListField> {
  List<String> _itemsToShowList = [];

  final _searchBreedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchBreedController.addListener(searchForRace);
  }

  @override
  void dispose() {
    super.dispose();
    _searchBreedController.dispose();
  }

  searchForRace() {
    setState(() {
      if (_searchBreedController.text.isNotEmpty) {
        _itemsToShowList = widget.itemsList
            .where((element) =>
                element
                    .toLowerCase()
                    .contains(_searchBreedController.text.toLowerCase()) &&
                element
                    .toLowerCase()
                    .startsWith(_searchBreedController.text.toLowerCase()))
            .toList();
        return;
      }
      _itemsToShowList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.showSearchBreed
        ? SearchList(
            focusNode: widget.searchFocusNode,
            hintText: widget.controller.text.isNotEmpty
                ? widget.controller.text
                : 'Dodaj rasę',
            list: _itemsToShowList,
            tagHandlerFunction: widget.selectBreed,
            controller: _searchBreedController,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: LabelText(
                text: widget.controller.text.isNotEmpty
                    ? widget.controller.text
                    : 'Dodaj rasę'));
  }
}
