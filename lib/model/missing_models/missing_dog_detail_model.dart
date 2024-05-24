import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class MissingDogDetailModel {
  final String? missingDogId;
  final String name;
  final Gender sex;
  final int breed;
  final Coordinates coordinates;
  final String missingDate;
  final int age;
  final String? description;
  final String? contactInfo;
  final int? reward;
  final List<String>? photos;

  MissingDogDetailModel(
      {this.missingDogId,
      required this.name,
      required this.sex,
      required this.breed,
      required this.coordinates,
      required this.missingDate,
      required this.age,
      this.description,
      this.contactInfo,
      this.reward,
      this.photos});

  Map toJson() => {
        'missingDogId': missingDogId,
        'name': name,
        'sex': sex.index,
        'breed': breed,
        'coordinates': coordinates,
        'missingDate': missingDate,
        'age': age,
        'description': description,
        'contactInfo': contactInfo,
        'reward': reward,
      };

  factory MissingDogDetailModel.fromJson(Map<String, dynamic> json) {
    List<String>? photosList;
    if (json['photos'] != null) {
      photosList = List<String>.from(json['photos']);
    }
    var missingDate = DateTime.parse(json['missingDate']);
    return MissingDogDetailModel(
      missingDogId: json['missingDogId'],
      name: json['name'],
      sex: Gender.values.firstWhere((gender) => gender.index == json['sex']),
      breed: json['breed'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      missingDate:
          '${missingDate.day}/${missingDate.month}/${missingDate.year} ${missingDate.hour}:${missingDate.minute}',
      age: json['age'],
      description: json['description'],
      contactInfo: json['contactInfo'],
      reward: json['reward'],
      photos: photosList,
    );
  }
}
