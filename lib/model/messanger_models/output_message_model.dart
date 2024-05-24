import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';

class RoomWithMessagesModel {
  final String roomId;
  final List<InputMessageModel> messages;
  String? pagingState;

  RoomWithMessagesModel(
      {required this.roomId, required this.messages, this.pagingState});
}
