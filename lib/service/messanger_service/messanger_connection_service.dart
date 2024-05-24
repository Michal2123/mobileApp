import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/helper/mixins/room_service_helpers_mixin.dart';
import 'package:flutter_mobile_app/interface/room_list_item_interface.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_friend_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/input_message_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/notification_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_room_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/output_message_model.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:signalr_netcore/signalr_client.dart';

class MessangerConnectionService
    with ChangeNotifier, DiagnosticableTreeMixin, RoomServiceHelpers {
  final _dioClient = KiwiContainer().resolve<DioClient>();

  OutputRoomModel? _currentRoomOpen;
  OutputRoomModel? get currentRoomOpen => _currentRoomOpen;
  set currentRoomOpen(OutputRoomModel? outputRoomModel) {
    _currentRoomOpen = outputRoomModel;
    notifyListeners();
  }

  static const String currentRoomOpenPropName = "currentRoomOpen";

  List<InputFriendModel> _friendsList = [];
  List<InputFriendModel> get friendsList => _friendsList;
  set friendsList(List<InputFriendModel> friendsList) {
    _friendsList = friendsList;
    notifyListeners();
  }

  static const String friendsListPropName = "friendsList";

  List<InputFriendModel> _friendsToShowList = [];
  List<InputFriendModel> get friendsToShowList => _friendsToShowList;
  set friendsToShowList(List<InputFriendModel> friendsToShowList) {
    _friendsToShowList = friendsToShowList;
    notifyListeners();
  }

  static const String friendsToShowListPropName = "friendsToShowList";

  List<String> _friendsidList = [];
  List<String> get friendsidList => _friendsidList;
  set friendsidList(List<String> friendsidList) {
    _friendsidList = friendsidList;
    notifyListeners();
  }

  static const String friendsidListPropName = "friendsidList";

  List<OutputRoomModel> _roomsList = [];
  List<OutputRoomModel> get roomsList => _roomsList;
  set roomsList(List<OutputRoomModel> roomsList) {
    _roomsList = roomsList;
    notifyListeners();
  }

  static const String roomsListPropName = "roomsList";

  List<RoomListItem> _roomListToShow = [];
  List<RoomListItem> get roomListToShow => _roomListToShow;
  set roomListToShow(List<RoomListItem> roomListToShow) {
    _roomListToShow = roomListToShow;
    notifyListeners();
  }

  static const String roomListToShowPropName = "roomListToShow";

  List<ChatMessageModel> _chatMessages = [];
  List<ChatMessageModel> get chatMessages => _chatMessages;
  set chatMessages(List<ChatMessageModel> chatMessages) {
    _chatMessages = chatMessages;
    notifyListeners();
  }

  static const String chatMessagesPropName = "chatMessages";

  List<ParticipantModel> _chatMembesrsToShow = [];
  List<ParticipantModel> get chatMembesrsToShow => _chatMembesrsToShow;
  set chatMembesrsToShow(List<ParticipantModel> chatMembesrsToShow) {
    _chatMembesrsToShow = chatMembesrsToShow;
    notifyListeners();
  }

  static const String chatMembesrsToShowPropName = "chatMembesrsToShow";

  List<NotyficationModel> _notyficationList = [];
  List<NotyficationModel> get notyficationList => _notyficationList;
  set notyficationList(List<NotyficationModel> notyficationList) {
    _notyficationList = notyficationList;
    notifyListeners();
  }

  static const String notyficationListPropName = "notyficationList";

  final String _serverUrl = '${config[ConfigFileKeys.chatURL.keyName]}/chat';
  HubConnection? hubConnection;
  final List<RoomWithMessagesModel> roomsWithMessageList = [];

  Future<void> openChatConnection() async {
    if (hubConnection == null) {
      hubConnection = HubConnectionBuilder()
          .withUrl(_serverUrl,
              options: HttpConnectionOptions(
                  accessTokenFactory: () async => await _dioClient
                      .refreshToken()
                      .then((_) => _dioClient.getAccessToken())))
          .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
          //.configureLogging(logger)
          .build();

      hubConnection!.on("on_message", handleIncommingChatMessage);
      hubConnection!.on("on_room_creation", handleIncommingRoomCreation);
      hubConnection!.on("on_notification", handleIncommingNotyfication);
      hubConnection!.on("on_room_edit", handleIncommingEditRoom);
    }

    await connectionCheck();
  }

  Future<void> connectionCheck() async {
    if (hubConnection?.state != HubConnectionState.Connected) {
      await hubConnection?.start();
    }
  }

  Future<void> closeConnection() async {
    if (hubConnection != null) {
      await hubConnection?.stop();
      if (hubConnection?.state == HubConnectionState.Disconnected) {
        roomsWithMessageList.clear();
        _roomsList.clear();
        _roomListToShow.clear();
        _friendsList.clear();
        _friendsToShowList.clear();
        _friendsidList.clear();
        _chatMembesrsToShow.clear();
        _notyficationList.clear();
        clearCurrentRoom();
      }
    }
  }

  Future<dynamic> invokeFuncion(String functionName,
      [List<Object>? request]) async {
    connectionCheck();
    return hubConnection
        ?.invoke(functionName, args: request)
        .then((result) => result)
        .onError((error, stackTrace) {
      throw error as Exception;
    });
  }

  void clearCurrentRoom() {
    _currentRoomOpen = null;
    _chatMessages.clear();
    notifyListeners();
  }

  void clearCreatingRoom() {
    _friendsToShowList = _friendsList;
    friendsidList.clear();
    notifyListeners();
  }

  void updateListMessag(InputMessageModel message) {
    var room = _roomsList.where((element) => element.id == message.roomId);
    if (room.isNotEmpty) {
      room.first.lastMessage = message;
      notifyListeners();
    }
  }

  void incommingMessageSoundPlayer(InputMessageModel message) {
    var room = _roomsList.where((element) => element.id == message.roomId);
    if (room.isNotEmpty) {
      if (!room.first.isMuted) {
        SystemSound.play(SystemSoundType.alert);
      }
    }
  }

  void insertToChatMessages(InputMessageModel message) {
    _chatMessages.insert(
        0, ChatMessageModel(message: message, expDate: ValueNotifier(false)));
    notifyListeners();
  }

  void filterToShowList() {}

  void handleIncommingRoomCreation(List<Object?>? args) {
    if (args != null) {
      var outputRoom = OutputRoomModel.getListFormJson(args).first;
      _roomsList.add(outputRoom);
    }

    notifyListeners();
  }

  void handleIncommingChatMessage(List<Object?>? args) {
    if (args != null) {
      var inputMessagesList = InputMessageModel.getListFromJson(args);
      if (inputMessagesList.first.roomId == currentRoomOpen?.id) {
        insertToChatMessages(inputMessagesList.first);
      }
      updateListMessag(inputMessagesList.first);
      insertToRoomMessage(inputMessagesList.first, roomsWithMessageList);
      incommingMessageSoundPlayer(inputMessagesList.first);
    }
  }

  void handleIncommingNotyfication(List<Object?>? args) {
    if (args != null) {
      var notyficationList = NotyficationModel.getListFromJson(args);
      _notyficationList.add(notyficationList.first);
      notifyListeners();
    }
  }

  void handleIncommingEditRoom(List<Object?>? args) {
    // var notyficationListModel = NotyficationListModel.fromArgs(args);
    // _notyficationList.add(notyficationListModel.notyficationList.first);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('friendsList', friendsList));
    properties.add(IterableProperty('friendsToShowList', friendsToShowList));
    properties.add(IterableProperty('friendsidList', friendsidList));
    properties.add(IterableProperty('roomListToShow', roomListToShow));
    properties.add(IterableProperty('roomsList', roomsList));
    properties.add(IterableProperty('chatMessages', chatMessages));
    properties.add(IterableProperty('chatMembesrsToShow', chatMembesrsToShow));
    properties.add(IterableProperty('notyficationList', notyficationList));
    properties.add(ObjectFlagProperty('currentRoomOpen', currentRoomOpen));
  }
}
