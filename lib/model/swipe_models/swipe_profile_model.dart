import 'package:flutter_mobile_app/utils/enums.dart';

class SwipeProfileModel {
  final String id;
  final String firstName;
  final String? description;
  final int distance;
  final List<String>? tags;
  final List<String>? photos;
  final List<SwipeProfileDogModel>? dogs;

  SwipeProfileModel(
      {required this.id,
      required this.firstName,
      required this.description,
      required this.distance,
      required this.tags,
      required this.photos,
      required this.dogs});

  factory SwipeProfileModel.fromJson(Map<String, dynamic> json) {
    var tempDogs = json['dogs'];
    var tempTags = json['tags'];
    var tempPhotos = json['photos'];

    List<SwipeProfileDogModel>? dogsList = tempDogs != null
        ? List<dynamic>.from(tempDogs)
            .map((e) => SwipeProfileDogModel.fromJson(e))
            .toList()
        : tempDogs;
    List<String>? tagsList =
        tempTags != null ? List<String>.from(tempTags) : tempTags;
    List<String>? photosList =
        tempPhotos != null ? List<String>.from(tempPhotos) : tempPhotos;

    return SwipeProfileModel(
      id: json['id'],
      firstName: json['firstName'],
      description: json['description'],
      distance: json['distance'],
      tags: tagsList,
      photos: photosList,
      dogs: dogsList,
    );
  }

  static List<SwipeProfileModel> getListFromJson(List<dynamic> json) {
    List<SwipeProfileModel> profileList =
        json.map((e) => SwipeProfileModel.fromJson(e)).toList();
    return profileList;
  }
}

class SwipeProfileDogModel {
  final String? id;
  final String name;
  final Gender sex;
  final int breed;
  final int age;
  final String description;
  final String photo;

  SwipeProfileDogModel({
    this.id,
    required this.name,
    required this.sex,
    required this.breed,
    required this.age,
    required this.description,
    required this.photo,
  });

  factory SwipeProfileDogModel.fromJson(Map<String, dynamic> json) {
    return SwipeProfileDogModel(
        name: json['name'],
        sex: Gender.values.firstWhere((gender) => gender.index == json['sex']),
        breed: json['breed'],
        age: json['age'],
        description: json['description'],
        photo: json['photo']);
  }
}
