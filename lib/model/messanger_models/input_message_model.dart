import 'package:flutter/foundation.dart';

class InputMessageModel {
  final String messageId;
  final String? roomId;
  final String userId;
  final String date;
  final String content;

  InputMessageModel(
      {required this.messageId,
      required this.userId,
      required this.date,
      required this.content,
      required this.roomId});

  Map toJson() => {'userId': userId, 'date': date, 'content': content};
  factory InputMessageModel.fromJson(Map<String, dynamic> json) {
    return InputMessageModel(
      messageId: json['messageId'],
      userId: json['userId'],
      date: json['date'],
      content: json['content'],
      roomId: json['roomId'],
    );
  }

  static List<InputMessageModel> getListFromJson(List<Object?> args) {
    List<InputMessageModel> inputMessageModel = args
        .map((e) => InputMessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return inputMessageModel;
  }
}

class ChatMessageModel {
  final InputMessageModel message;
  ValueNotifier<bool> expDate;

  ChatMessageModel({required this.message, required this.expDate});
}
