class ExerciseDetailModel {
  final String id;
  final String title;
  final String description;
  final String? image;

  const ExerciseDetailModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image});

  factory ExerciseDetailModel.fromJson(Map<String, dynamic> json) {
    return ExerciseDetailModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image']);
  }
}
