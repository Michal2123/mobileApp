import 'package:flutter/material.dart';

abstract class RoomListItem {
  String? get roomName;
  Widget buildRoom(BuildContext context);
}
