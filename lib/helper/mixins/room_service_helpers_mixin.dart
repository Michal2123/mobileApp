import 'package:flutter_mobile_app/interface/room_list_item_interface.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_message_model.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/room_list/room_item.dart';

mixin RoomServiceHelpers {
  /// Creates new room object
  OutputRoomModel createRoomHelper(
      List<InputFriendModel> friendsList, String roomId,
      [String? roomName, bool isAtive = true, InputMessageModel? lastMessage]) {
    List<ParticipantModel> participantsList = [];

    for (var friend in friendsList) {
      participantsList.add(ParticipantModel(
          userId: friend.userId,
          userName: friend.userName,
          profileImage: null));
    }

    return OutputRoomModel(
        id: roomId,
        lastMessage: lastMessage,
        participants: participantsList,
        roomName: roomName ?? participantsList.map((e) => e.userName).join(','),
        isActive: isAtive);
  }

  /// Inserting incomming message to list of rooms and messages [roomsWithMessageList]
  void insertToRoomMessage(InputMessageModel incomingMessage,
      List<RoomWithMessagesModel> roomsWithMessageList) {
    var messages = roomsWithMessageList
        .firstWhere((room) => room.roomId == incomingMessage.roomId)
        .messages;
    messages.insert(0, incomingMessage);
  }

  /// Add new room with message to [roomsWithMessageList]
  void addRoomsWithMessageHelper(
      String roomId, List<RoomWithMessagesModel> roomsWithMessageList,
      [String? paginingState, List<InputMessageModel>? messages]) {
    roomsWithMessageList.add(RoomWithMessagesModel(
        roomId: roomId,
        messages: messages ?? <InputMessageModel>[],
        pagingState: paginingState));
  }

  OutputRoomModel? removeParticipantsHelper(
      List<String> participantsIdList, OutputRoomModel? room) {
    if (room != null) {
      if (room.roomName
          .contains(room.participants.map((e) => e.userName).join(', '))) {
        room.roomName = '';
      }
      for (var id in participantsIdList) {
        room.participants
            .removeWhere((roomParticipant) => roomParticipant.userId == id);
      }
      if (room.roomName.isEmpty) {
        room.roomName = room.participants.map((e) => e.userName).join(', ');
      }
    }
    return room;
  }

  OutputRoomModel? addParticipantHelper(OutputRoomModel? room,
      List<String> participantsIdList, List<InputFriendModel> friendsList) {
    if (room != null) {
      if (room.roomName
          .contains(room.participants.map((e) => e.userName).join(', '))) {
        room.roomName = '';
      }
      List<ParticipantModel> combineList = room.participants.toList();
      var frendsToAdd = participantsIdList
          .map((participantId) => friendsList
              .firstWhere((friend) => participantId == friend.userId))
          .toList();
      for (var friend in frendsToAdd) {
        combineList.add(ParticipantModel(
            userId: friend.userId,
            userName: friend.userName,
            profileImage: null));
      }

      room.participants = combineList;
      if (room.roomName.isEmpty) {
        room.roomName = room.participants.map((e) => e.userName).join(', ');
      }
    }
    return room;
  }

  OutputRoomModel? checkIsGorupRoom(
      OutputRoomModel? currentRoom, List<InputFriendModel> friendsList) {
    if (currentRoom != null) {
      var participantIdList = currentRoom.participants.map((e) => e.userId);
      currentRoom.isGroupChat = true;
      if (participantIdList.length == 1) {
        var isParticipantOurFriend = friendsList
            .any((friend) => friend.userId == participantIdList.first);
        if (isParticipantOurFriend) {
          var matchFriend = friendsList
              .firstWhere((friend) => friend.userId == participantIdList.first);
          if (matchFriend.defaultRoom == currentRoom.id) {
            currentRoom.isGroupChat = false;
          }
        }
      }
    }
    return currentRoom;
  }

  List<RoomListItem> generateListOfRooms(List<OutputRoomModel> roomsList) {
    return List<RoomListItem>.generate(
        roomsList.length, (index) => RoomItem(roomModel: roomsList[index]));
  }
}
