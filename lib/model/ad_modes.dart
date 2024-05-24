class RoomListAdModel {
  final String id;
  final String title;
  final String content;
  final String describe;
  RoomListAdModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.describe});

  factory RoomListAdModel.fromJson(Map<String, dynamic> json) {
    return RoomListAdModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        describe: json['describe']);
  }
}
