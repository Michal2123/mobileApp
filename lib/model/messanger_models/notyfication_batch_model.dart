import 'package:flutter_mobile_app/model/messanger_models/notification_model.dart';

class NotyficationBatchModel {
  final List<NotyficationModel> notyficationList;
  final String? pagingStateBase64;

  NotyficationBatchModel(
      {required this.notyficationList, required this.pagingStateBase64});

  factory NotyficationBatchModel.fromJson(Map<String, dynamic> json) {
    List<NotyficationModel> notyficationList =
        List<dynamic>.from(json['notifications'])
            .map((e) => NotyficationModel.fromJson(e))
            .toList();

    return NotyficationBatchModel(
        notyficationList: notyficationList,
        pagingStateBase64: json['pagingStateBase64']);
  }
}
