import 'package:flutter_mobile_app/utils/enums.dart';

class EditDogModel {
  final String? dogId;
  final String name;
  final String? dateOfBirth;
  final Gender sex;
  final int breed;
  final String description;

  EditDogModel(
      {this.dogId,
      required this.name,
      required this.dateOfBirth,
      required this.sex,
      required this.breed,
      required this.description});

  Map toJson() => {
        'dogId': dogId,
        'name': name,
        'dateOfBirth': dateOfBirth,
        'sex': sex.index,
        'breed': breed,
        'description': description,
      };

  factory EditDogModel.fromJson(Map<String, dynamic> json) {
    return EditDogModel(
        name: json['name'],
        dateOfBirth: json['dateOfBirth'],
        sex: Gender.values.firstWhere((gender) => gender.index == json['sex']),
        breed: json['breed'],
        description: json['description']);
  }
}

class GetDogDetailModel {
  final String name;
  final String? dateOfBirth;
  final Gender sex;
  final int breed;
  final String description;
  final String? photo;

  GetDogDetailModel({
    required this.name,
    required this.dateOfBirth,
    required this.sex,
    required this.breed,
    required this.description,
    required this.photo,
  });

  factory GetDogDetailModel.fromJson(Map<String, dynamic> json) {
    return GetDogDetailModel(
        name: json['name'],
        dateOfBirth: json['dateOfBirth'],
        sex: Gender.values.firstWhere((gender) => gender.index == json['sex']),
        breed: json['breed'],
        description: json['description'],
        photo: json['photo']);
  }

  static List<GetDogDetailModel> getListFromJson(List<dynamic> json) {
    List<GetDogDetailModel> tempDogDetailList =
        json.map((e) => GetDogDetailModel.fromJson(e)).toList();
    return tempDogDetailList;
  }
}

class GetDogModel {
  final String dogId;
  final String name;

  GetDogModel({required this.dogId, required this.name});

  factory GetDogModel.fromJson(Map<String, dynamic> json) {
    return GetDogModel(dogId: json['dogId'], name: json['name']);
  }

  static List<GetDogModel> getListFromJson(List<dynamic> json) {
    List<GetDogModel> tempDogList =
        json.map((e) => GetDogModel.fromJson(e)).toList();
    return tempDogList;
  }
}
