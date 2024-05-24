class InputFriendModel {
  final String userId;
  final String userName;
  final String? defaultRoom;

  const InputFriendModel(
      {required this.userId, required this.userName, this.defaultRoom});

  factory InputFriendModel.fromJson(Map<String, dynamic> json) {
    return InputFriendModel(
        userId: json['userId'],
        userName: json['userName'],
        defaultRoom: json['defaultRoom']);
  }

  static List<InputFriendModel> getListFromJson(List<dynamic> json) {
    List<InputFriendModel> inputFiendsModelList =
        json.map((e) => InputFriendModel.fromJson(e)).toList();
    return inputFiendsModelList;
  }
}
