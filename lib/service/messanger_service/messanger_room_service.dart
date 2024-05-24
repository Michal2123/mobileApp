import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/mixins/room_service_helpers_mixin.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class MessangerRoomService
    with ChangeNotifier, DiagnosticableTreeMixin, RoomServiceHelpers {
  MessangerConnectionService _messangerConnService =
      KiwiContainer().resolve<MessangerConnectionService>();
  MessangerChatService? _messangerChatService;

  void update(MessangerConnectionService messangerService,
      MessangerChatService messangerChatService) {
    _messangerConnService = messangerService;
    _messangerChatService = messangerChatService;
  }

  Future<void> init() async {}

  Future<void> joinRooms() async {
    await _messangerConnService
        .invokeFuncion(MessangerInvokes.joinRooms.methodName)
        .then((response) {
      if (response != null) {
        var outputRoomsList = OutputRoomModel.getListFormJson(response);
        if (_messangerConnService.roomsList.length != outputRoomsList.length) {
          _messangerConnService.roomsList = outputRoomsList;
        }
      }
    });
  }

  Future<String> addRoom(List<String> friendsIdList,
      [String? defaultRoom]) async {
    if (defaultRoom != null) {
      return defaultRoom;
    }
    return await _messangerConnService.invokeFuncion(
        MessangerInvokes.createRoom.methodName,
        <Object>[friendsIdList, '']).then((roomId) {
      if (roomId != null) {
        addRoomToLocalRoomList(friendsIdList, roomId);
      }
      return roomId;
    });
  }

  Future<bool> enterChatRoom(String roomId,
      [List<String>? friendsIdList]) async {
    if (!_messangerConnService.roomsList.any((room) => room.id == roomId)) {
      return false;
    }
    _messangerConnService.currentRoomOpen = checkIsGorupRoom(
        _messangerConnService.roomsList.firstWhere((room) => room.id == roomId),
        _messangerConnService.friendsList);
    _messangerConnService.chatMembesrsToShow =
        _messangerConnService.currentRoomOpen?.participants ?? [];

    await getAllMessages(roomId);
    var roomMessages = _messangerConnService.roomsWithMessageList
        .firstWhere((room) => room.roomId == roomId)
        .messages;
    _messangerChatService?.addToChatMessages(roomMessages);

    return true;
  }

  Future<void> leaveRoom(String roomId) async {
    await _messangerConnService.invokeFuncion(
        MessangerInvokes.leaveRoom.methodName, <Object>[roomId]).then((_) {
      _messangerConnService.roomsList.removeWhere((room) => room.id == roomId);
      _messangerConnService.roomsWithMessageList
          .removeWhere((room) => room.roomId == roomId);
      notifyListeners();
    });
  }

  Future<void> getFriends() async {
    await _messangerConnService
        .invokeFuncion(MessangerInvokes.getFriends.methodName)
        .then((response) {
      if (response != null) {
        var friendsListModel = InputFriendModel.getListFromJson(response);
        _messangerConnService.friendsList = friendsListModel;
      }
    });
  }

  /// Block or unblock chat room depend on open room [isActive]
  Future<void> changeBlockState() async {
    var currentRoomOpen = _messangerConnService.currentRoomOpen;
    if (currentRoomOpen != null) {
      _messangerConnService.invokeFuncion(
          currentRoomOpen.isActive
              ? MessangerInvokes.blockUserAsync.methodName
              : MessangerInvokes.unblockUserAsync.methodName,
          <Object>[
            currentRoomOpen.participants.first.userId
          ]).then((_) => changeRoomisActive(currentRoomOpen));
    }
  }

  void muteRoom() {
    var currentRoom = _messangerConnService.currentRoomOpen;
    if (currentRoom != null) {
      currentRoom.isMuted = !currentRoom.isMuted;
      _messangerConnService.currentRoomOpen = currentRoom;
    }
  }

  Future<void> chagneRoomName(String roomId, String newRoomName) async {
    var room = _messangerConnService.roomsList
        .where((room) => room.id == roomId)
        .first;
    if (room.roomName != newRoomName) {
      await _messangerConnService.invokeFuncion(
          MessangerInvokes.editChatRoomName.methodName,
          <Object>[roomId, newRoomName]).then((_) {
        room.roomName = newRoomName;
        _messangerConnService.currentRoomOpen = room;
      });
    }
  }

  /// After blocking or unblocking user changes room [isActive]
  void changeRoomisActive(OutputRoomModel? currentRoomOpen) {
    if (currentRoomOpen != null) {
      currentRoomOpen.isActive = !currentRoomOpen.isActive;
      _messangerConnService.currentRoomOpen = currentRoomOpen;
    }
  }

  void addRoomToLocalRoomList(List<String> friendsIdList, roomId) {
    var frendsToAdd = friendsIdList
        .map((friendId) => _messangerConnService.friendsList
            .firstWhere((friend) => friendId == friend.userId))
        .toList();
    var outputRoom = createRoomHelper(frendsToAdd, roomId);
    _messangerConnService.roomsList.add(outputRoom);
    addRoomsWithMessageHelper(
        roomId, _messangerConnService.roomsWithMessageList);
    notifyListeners();
  }

  /// Ivoke messages for specify room [roomId] and add this room with messages to [roomsWithMessageList]
  Future<void> getAllMessages(String roomId) async {
    await _messangerChatService
        ?.invokeGetMessages(_messangerConnService.hubConnection, roomId)
        .then((response) {
      addRoomsWithMessageHelper(
          roomId,
          _messangerConnService.roomsWithMessageList,
          response?.pagingStateBase64,
          response?.messages);
      notifyListeners();
    });
  }

  void updatingRoomListMessageNotification(InputMessageModel message) {
    var room = _messangerConnService.roomsList
        .where((element) => element.id == message.roomId);
    if (room.isNotEmpty) {
      room.first.lastMessage = message;
      notifyListeners();
    }
  }
}
