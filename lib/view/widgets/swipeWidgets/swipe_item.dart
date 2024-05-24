import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/interface/swipe_list_item_interface.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_page.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/widgets/swipeWidgets/swipe_widget/swipe_widget.dart';

class SwipeItem implements SwipeListItem {
  const SwipeItem({required this.swipeProfileModel, this.swipeController});
  final SwipeProfileModel swipeProfileModel;
  final SwipeController? swipeController;

  @override
  String get firstName => swipeProfileModel.firstName;

  @override
  String get id => swipeProfileModel.id;

  @override
  List<String> get photos => swipeProfileModel.photos ?? [];

  @override
  Function? showAd() => null;

  @override
  Widget buildSwipe(BuildContext context) {
    return SwipeWidget(
      firstName: swipeProfileModel.firstName,
      imagePath: swipeProfileModel.photos?.first,
      dogs: swipeProfileModel.dogs,
      onClickFunction: () => onClick(context),
    );
  }

  void onClick(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailProfile(
              swipeProfileModel: swipeProfileModel,
              swipeController: swipeController,
            )));
  }
}
