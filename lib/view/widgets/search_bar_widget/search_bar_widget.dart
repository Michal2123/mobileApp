import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/input_form_field/input_field_widged.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_sections/prefix_icon_section.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_sections/sufix_button_section.dart';

class CustomeSearchBar extends StatelessWidget {
  const CustomeSearchBar(
      {super.key, required this.searchBarTextController, this.clearController});
  final TextEditingController searchBarTextController;
  final Function()? clearController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 15),
        child: Stack(alignment: Alignment.center, children: [
          CustomeInputField(
            controller: searchBarTextController,
            name: 'search',
            obscureText: false,
            title: 'Szukaj',
            keyboardType: TextInputType.text,
            maxLines: 2,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 40,
            ),
          ),
          const SearchBarPrefixIconSection(),
          searchBarTextController.text.isNotEmpty
              ? SearchBarSufixButtonSectin(
                  clearController: clearController,
                )
              : const SizedBox(),
        ]));
  }
}
