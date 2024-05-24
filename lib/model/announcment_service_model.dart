class AnnouncmentServiceModel {
  final String id;
  final String title;
  final String describe;
  final String adress;
  final double score;
  final int type;
  const AnnouncmentServiceModel(
      {required this.id,
      required this.title,
      required this.describe,
      required this.adress,
      required this.score,
      required this.type});

  factory AnnouncmentServiceModel.fromJson(Map<String, dynamic> json) {
    return AnnouncmentServiceModel(
        id: json['id'],
        title: json['title'],
        describe: json['describe'],
        adress: json['adress'],
        score: json['score'],
        type: json['type']);
  }
}
