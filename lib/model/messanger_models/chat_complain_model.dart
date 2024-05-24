class ChatComplainModel {
  ChatComplainModel(
      {required this.id,
      required this.isExpand,
      required this.titles,
      required this.checkList});
  final String id;
  bool isExpand;
  final List<String> titles;
  final List<bool> checkList;
}
