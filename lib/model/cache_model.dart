class CachModel {
  final dynamic body;
  final String time;
  CachModel({required this.body, required this.time});

  Map toJson() => {'body': body, 'time': time};
  factory CachModel.fromJson(Map<String, dynamic> json) {
    return CachModel(
      body: json['body'],
      time: json['time'],
    );
  }
}
