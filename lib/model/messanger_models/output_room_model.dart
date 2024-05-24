import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';

class OutputRoomModel {
  final String id;
  String roomName;
  List<ParticipantModel> participants;
  InputMessageModel? lastMessage;
  bool isActive;
  bool isMuted = false;
  bool? isGroupChat;

  OutputRoomModel(
      {required this.id,
      required this.participants,
      required this.roomName,
      required this.lastMessage,
      required this.isActive});

  factory OutputRoomModel.fromJson(Map<String, dynamic> json) {
    String roomName = json['chatName'];
    List<ParticipantModel> participantsList =
        List<dynamic>.from(json['participants'])
            .map((e) => ParticipantModel.fromJson(e))
            .toList();

    if (roomName.isEmpty) {
      roomName = participantsList.map((e) => e.userName).join(',');
    }

    return OutputRoomModel(
      id: json['id'],
      roomName: roomName,
      participants: participantsList,
      lastMessage: json['lastMessage'] != null
          ? InputMessageModel.fromJson(json['lastMessage'])
          : null,
      isActive: json['isActive'],
    );
  }

  static List<OutputRoomModel> getListFormJson(List<Object?> json) {
    List<OutputRoomModel> outputRoomList = json
        .map((e) => OutputRoomModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return outputRoomList;
  }
}

class ParticipantModel {
  final String userId;
  final String userName;
  final String? profileImage;

  ParticipantModel(
      {required this.userId,
      required this.userName,
      required this.profileImage});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
        userId: json['userId'],
        userName: json['userName'],
        profileImage: json['profileImage']);
  }

  static List<ParticipantModel> getListFromJson(List<dynamic> json) {
    List<ParticipantModel> participantList =
        json.map((e) => ParticipantModel.fromJson(e)).toList();
    return participantList;
  }
}
