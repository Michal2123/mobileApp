import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:flutter_mobile_app/model/messanger_models/notification_model.dart';
import 'package:flutter_mobile_app/model/messanger_models/notyfication_batch_model.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class MessangerNotificationService
    with ChangeNotifier, DiagnosticableTreeMixin {
  MessangerConnectionService _messangerService =
      KiwiContainer().resolve<MessangerConnectionService>();
  String? _notyficationPagingState;

  void update(MessangerConnectionService messangerService) {
    _messangerService = messangerService;
  }

  Future<List<NotyficationModel>?> invokeGetNotyfications(
      [String? notyficationPagingState]) async {
    return await _messangerService.invokeFuncion(
        MessangerInvokes.getNotifications.methodName,
        <Object>[20, notyficationPagingState ?? '']).then((response) {
      if (response != null) {
        var notyficationListModel = NotyficationBatchModel.fromJson(response);
        notyficationPagingState = notyficationListModel.pagingStateBase64;
        return notyficationListModel.notyficationList;
      }
      return response;
    });
  }

  Future<void> getNotyfications() async {
    await invokeGetNotyfications().then((notyficationModelList) {
      if (notyficationModelList != null) {
        _messangerService.notyficationList = notyficationModelList;
      }
    });
  }

  Future<void> getOlderNotyfications() async {
    await invokeGetNotyfications(_notyficationPagingState)
        .then((notyficationModelList) {
      if (notyficationModelList != null) {
        for (var notyfication in notyficationModelList) {
          if (!_messangerService.notyficationList
              .any((element) => element.id == notyfication.id)) {
            _messangerService.notyficationList.add(notyfication);
          }
        }
        notifyListeners();
      }
    });
  }

  Future<void> notyficationReadStatusChange(String notyficationId) async {
    await _messangerService.invokeFuncion(
        MessangerInvokes.changeNotificationReadStatus.methodName,
        <Object>[notyficationId]);
  }
}
