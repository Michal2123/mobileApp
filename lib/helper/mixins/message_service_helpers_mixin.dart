import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

mixin MessageServiceHelpers {
  final _storage = KiwiContainer().resolve<FlutterSecureStorage>();

  Future<InputMessageModel?> createMessageToSendHelper(
      Object? result, String roomId, String messageContent) {
    return _storage.read(key: StorageKeys.userId.name).then((userId) {
      if (userId != null) {
        return InputMessageModel(
            messageId: result?.toString() ?? '',
            roomId: roomId,
            userId: userId,
            date: DateTime.now().toIso8601String(),
            content: messageContent);
      }
      return null;
    });
  }

  void expDateHandler(int? index, List<ChatMessageModel> chatMessages) {
    if (index != null) {
      chatMessages[index].expDate =
          ValueNotifier<bool>(!chatMessages[index].expDate.value);
      return;
    }
    for (var chatMessage in chatMessages) {
      chatMessage.expDate = ValueNotifier<bool>(false);
    }
  }
}
