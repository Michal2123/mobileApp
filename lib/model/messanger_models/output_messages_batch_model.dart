import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';

class OutputMessagesBatchModel {
  final List<InputMessageModel> messages;
  final String? pagingStateBase64;

  OutputMessagesBatchModel(
      {required this.messages, required this.pagingStateBase64});

  factory OutputMessagesBatchModel.fromJson(Map<String, dynamic> json) {
    List<InputMessageModel> messagesModel = List<dynamic>.from(json['messages'])
        .map((e) => InputMessageModel.fromJson(e))
        .toList();

    return OutputMessagesBatchModel(
      messages: messagesModel,
      pagingStateBase64: json['pagingStateBase64'],
    );
  }
}
