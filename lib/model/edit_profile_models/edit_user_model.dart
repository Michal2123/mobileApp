class EditUserModel {
  final String firstName;
  final Coordinates coordinates;
  final String? description;
  final List<String>? tags;
  final Map<String, dynamic>? photos;

  EditUserModel({
    required this.firstName,
    required this.coordinates,
    required this.description,
    required this.tags,
    this.photos,
  });

  Map toJson() => {
        'firstName': firstName,
        'coordinates': coordinates,
        'description': description,
        'tags': tags,
        'photos': photos,
      };

  factory EditUserModel.fromJson(Map<String, dynamic> json) {
    return EditUserModel(
      firstName: json['firstName'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      description: json['description'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      photos: json['photos'],
    );
  }
}

class Coordinates {
  final double x;
  final double y;

  Coordinates({required this.x, required this.y});

  Map toJson() => {
        'x': x,
        'y': y,
      };

  factory Coordinates.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Coordinates(
        x: 0,
        y: 0,
      );
    }
    return Coordinates(
      x: json['x'],
      y: json['y'],
    );
  }
}
