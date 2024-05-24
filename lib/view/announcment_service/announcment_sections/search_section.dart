import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/announcment_service_model.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/popups/checkbox_popup/checkbox_popup.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class AnnouncmentSearchSection extends StatelessWidget {
  const AnnouncmentSearchSection({
    super.key,
    required this.announcmentServiceMockList,
    required this.filtersViewList,
    required this.searchBarTextController,
    required this.searchFunction,
    required this.filterFunction,
  });
  final List<AnnouncmentServiceModel> announcmentServiceMockList;
  final TextEditingController searchBarTextController;
  final Function() searchFunction;
  final Function(List<Map<String, dynamic>> filtersViewList) filterFunction;

  final List<Map<String, dynamic>> filtersViewList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConstant.backgroundScaffoldColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => StatefulPopup(
                    filters: filtersViewList,
                    filterSubmitFunction: () {
                      filterFunction(filtersViewList);
                      Navigator.pop(context);
                    },
                  ),
                ),
                child: const InputLabelText(text: 'Filtruj'),
              ),
            ),
            CustomeSearchBar(
              searchBarTextController: searchBarTextController,
              clearController: () {
                searchBarTextController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
