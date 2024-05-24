class MissingDogPreviewModel {
  final String id;
  final String? name;
  final int breed;
  final String missingDate;
  final String? photo;
  const MissingDogPreviewModel(
      {required this.id,
      required this.name,
      required this.breed,
      required this.missingDate,
      required this.photo});

  factory MissingDogPreviewModel.frimJson(Map<String, dynamic> json) {
    return MissingDogPreviewModel(
        id: json['id'],
        name: json['name'],
        breed: json['breed'],
        missingDate: json['missingDate'],
        photo: json['photo']);
  }

  static List<MissingDogPreviewModel> getListFromJson(List<dynamic> json) {
    List<MissingDogPreviewModel> currnetAdsList =
        json.map((e) => MissingDogPreviewModel.frimJson(e)).toList();
    return currnetAdsList;
  }
}
