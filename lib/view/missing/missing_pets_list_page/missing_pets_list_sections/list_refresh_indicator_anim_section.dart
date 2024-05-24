import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_list_page/missing_pets_list_page.dart';

class MissingPetsListRefreshIndicatorAnimSection extends StatefulWidget {
  const MissingPetsListRefreshIndicatorAnimSection(
      {super.key, required this.missingPetsListController});
  final MissingPetsListController missingPetsListController;

  @override
  State<MissingPetsListRefreshIndicatorAnimSection> createState() =>
      _MissingPetsListRefreshIndicatorAnimSectionState();
}

class _MissingPetsListRefreshIndicatorAnimSectionState
    extends State<MissingPetsListRefreshIndicatorAnimSection> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.missingPetsListController.getIsLoading = getIsLoading;
    });
  }

  void getIsLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding:
              _isLoading ? const EdgeInsets.all(10) : const EdgeInsets.all(0),
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              width: _isLoading ? 25 : 0,
              height: _isLoading ? 25 : 0,
              child: CircularProgressIndicator(
                color: ColorConstant.inkWellTextColor,
              ))),
    );
  }
}
