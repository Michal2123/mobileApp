class ExerciseModel {
  final String id;
  final String title;
  final String? image;
  final CategoryModel category;

  ExerciseModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.category});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        category: CategoryModel.fromJson(json['category']));
  }

  static List<ExerciseModel> getListFromJson(List<dynamic> json) {
    List<ExerciseModel> exercisesList =
        json.map((e) => ExerciseModel.fromJson(e)).toList();
    return exercisesList;
  }
}

class CategoryModel {
  final int key;
  final String value;

  const CategoryModel({required this.key, required this.value});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(key: json['key'], value: json['value']);
  }
}
