import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/mixins/message_service_helpers_mixin.dart';
import 'package:flutter_mobile_app/helper/mixins/room_service_helpers_mixin.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_messages_batch_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:signalr_netcore/signalr_client.dart';

class MessangerChatService
    with
        ChangeNotifier,
        DiagnosticableTreeMixin,
        RoomServiceHelpers,
        MessageServiceHelpers {
  MessangerConnectionService _messangerConnService =
      KiwiContainer().resolve<MessangerConnectionService>();

  void update(MessangerConnectionService messangerService) {
    _messangerConnService = messangerService;
  }

  Future<void> init() async {}

  Future<OutputMessagesBatchModel?> invokeGetMessages(
      HubConnection? hubConnection, String roomId,
      [String? pagingState]) async {
    var result = await _messangerConnService.invokeFuncion(
        MessangerInvokes.getMessages.methodName,
        <Object>[roomId, 20, pagingState ?? '']);
    if (result != null) {
      return OutputMessagesBatchModel.fromJson(result as dynamic);
    }
    return result as dynamic;
  }

  void addToChatMessages(List<InputMessageModel> messages) {
    var chatMessages = _messangerConnService.chatMessages.toList();
    for (var message in messages) {
      chatMessages.add(
          ChatMessageModel(message: message, expDate: ValueNotifier(false)));
    }
    _messangerConnService.chatMessages = chatMessages;
  }

  void insertToChatMessages(InputMessageModel message) {
    var chatMessages = _messangerConnService.chatMessages.toList();
    chatMessages.insert(
        0, ChatMessageModel(message: message, expDate: ValueNotifier(false)));
    _messangerConnService.chatMessages = chatMessages;
  }

  Future<void> sendChatMessage(String roomId, String messageContent) async {
    if (messageContent.isEmpty) {
      return;
    }
    await _messangerConnService.invokeFuncion(
        MessangerInvokes.sendMessage.methodName,
        <Object>[roomId, messageContent]).then((response) {
      createMessageToSendHelper(response, roomId, messageContent)
          .then((outputMessage) {
        if (outputMessage != null) {
          _messangerConnService.updateListMessag(outputMessage);
          insertToRoomMessage(
              outputMessage, _messangerConnService.roomsWithMessageList);
          insertToChatMessages(outputMessage);
        }
      });
    });
  }

  Future<void> getOlderMessages(String? roomId) async {
    if (roomId != null) {
      var room = _messangerConnService.roomsWithMessageList
          .firstWhere((room) => room.roomId == roomId);
      var roomMessages = room.messages;
      await invokeGetMessages(null, roomId, room.pagingState)
          .then((messageBatchModel) {
        if (messageBatchModel != null) {
          for (var message in messageBatchModel.messages) {
            if (!roomMessages
                .any((element) => element.messageId == message.messageId)) {
              roomMessages.add(message);
              addToChatMessages([message]);
            }
          }
        }
      });
    }
  }

  Future<void> addParticipantToChat(List<String> participantIdList) async {
    var currnetRoomOpen = _messangerConnService.currentRoomOpen;
    if (currnetRoomOpen != null) {
      await _messangerConnService.invokeFuncion(
          MessangerInvokes.addParticipant.methodName,
          <Object>[currnetRoomOpen.id, participantIdList]).then((_) {
        _messangerConnService.currentRoomOpen = addParticipantHelper(
            currnetRoomOpen,
            participantIdList,
            _messangerConnService.friendsList);
      });
    }
  }

  Future<void> removeParticipantfromChat(List<String> participantsId) async {
    var currnetRoomOpen = _messangerConnService.currentRoomOpen;
    if (currnetRoomOpen != null) {
      await _messangerConnService.invokeFuncion(
          MessangerInvokes.removeParticipant.methodName,
          <Object>[currnetRoomOpen.id, participantsId]).then((_) {
        _messangerConnService.currentRoomOpen =
            removeParticipantsHelper(participantsId, currnetRoomOpen);
      });
    }
  }

  void expDate(int? index) {
    expDateHandler(index, _messangerConnService.chatMessages);
    notifyListeners();
  }
}
