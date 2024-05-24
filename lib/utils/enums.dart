enum MainPages {
  missingPage,
  excercisePage,
  swipePage,
  messangerPage,
  profilePage,
  announcmentPage,
  none
}

enum StorageKeys { token, refreshToken, userId }

enum ConfigFileKeys {
  apiURL('apiURL'),
  chatURL('chatURL'),
  authURL('authURL'),
  connectonTimeOut('connectonTimeOut'),
  cacheDurationInHour('cacheDurationInHour'),
  cacheDurationInDays('cacheDurationInDays'),
  exerciseOther('exerciseOther'),
  exerciseObedience('exerciseObedience'),
  exerciseRecreation('exerciseRecreation'),
  exerciseSport('exerciseSport');

  final String keyName;
  const ConfigFileKeys(this.keyName);
}

enum MessangerInvokes {
  addParticipant('AddParticipant'),
  blockUserAsync('BlockUserAsync'),
  createRoom('CreateRoom'),
  changeNotificationReadStatus('ChangeNotificationReadStatus'),
  editChatRoomName('EditChatRoomName'),
  joinRooms('JoinRooms'),
  leaveRoom('LeaveRoom'),
  removeParticipant('RemoveParticipant'),
  sendMessage('SendMessage'),
  getFriends('GetFriends'),
  getNotifications('GgetNotifications'),
  getMessages('GetMessages'),
  unblockUserAsync('UnblockUserAsync');

  final String methodName;
  const MessangerInvokes(this.methodName);
}

enum Gender { female, male }

enum ExercisesPageTabs {
  allExercises(false),
  savedExercises(true);

  final bool isSavedOpen;
  const ExercisesPageTabs(this.isSavedOpen);
}

enum MessangerPageTabs {
  roomList(true),
  notyfication(false);

  final bool value;
  const MessangerPageTabs(this.value);
}

enum MissingPageTabs {
  announcementTab(true),
  myAnnouncementTab(false);

  final bool value;
  const MissingPageTabs(this.value);
}

enum DefaultMapCoordinates {
  x(52.23),
  y(21.01);

  final double value;
  const DefaultMapCoordinates(this.value);
}

// enum StorageKeys {
//   token('token'),
//   refreshToken('refreshToken'),
//   userId('userId');

//   const StorageKeys(this.key);
//   final String key;
// }
