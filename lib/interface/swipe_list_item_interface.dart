import 'package:flutter/material.dart';

abstract class SwipeListItem {
  String get id;
  String get firstName;
  List<String> get photos;
  Widget buildSwipe(BuildContext context);
  Function? showAd();
}
