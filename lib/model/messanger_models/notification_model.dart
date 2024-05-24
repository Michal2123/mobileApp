class NotyficationModel {
  final String id;
  final int notificationType;
  final String title;
  final String? content;

  const NotyficationModel(
      {required this.id,
      required this.notificationType,
      required this.title,
      required this.content});

  factory NotyficationModel.fromJson(Map<String, dynamic> json) {
    return NotyficationModel(
        id: json['id'],
        notificationType: json['notificationType'],
        title: json['title'],
        content: json['content']);
  }

  static List<NotyficationModel> getListFromJson(List<Object?> args) {
    List<NotyficationModel> notyficationList = args
        .map((e) => NotyficationModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return notyficationList;
  }
}
