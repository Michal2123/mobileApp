import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/popups/contextless_popups.dart';
import 'package:signalr_netcore/errors.dart';

import '../main.dart';

class ExceptionHandler implements Exception {
  late String _message;
  final List<String> _snackBarMessages = [];

  static final ExceptionHandler _instance = ExceptionHandler._internal();

  factory ExceptionHandler() {
    return _instance;
  }
  ExceptionHandler._internal();

  snackBarHandler(String message) async {
    if (!_snackBarMessages.contains(message)) {
      _snackBarMessages.add(message);
      rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ));
      await Future.delayed(const Duration(seconds: 5));
      _snackBarMessages.removeWhere((element) => element == message);
    }
  }

  fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        _message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        _message = "Connection timeout with API server";
        snackBarHandler(_message);
        break;
      case DioExceptionType.receiveTimeout:
        _message = "Receive timeout in connection with API server";
        snackBarHandler(_message);
        break;
      case DioExceptionType.badResponse:
        _message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

        break;
      case DioExceptionType.sendTimeout:
        _message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        var error = dioError.error as SocketException;
        if (error.message.isNotEmpty) {
          if (error.message == 'Connection failed') {
            _message = 'No Internet';
            snackBarHandler(_message);
            break;
          }
        }
        _message = "Unexpected error occurred";
        break;
      default:
        _message = "Something went wrong";
        break;
    }
  }

  fromOtherError(Exception exception) {
    if (exception.runtimeType != DioException) {
      switch (exception) {
        case GeneralError _:
          _message = "Something went wrong";
          if (exception.message?.contains('HubConnection') == true ||
              exception.message?.contains('Connected') == true) {
            _message = "cannot connect to messanger server";
          }
          snackBarHandler(_message);
          break;
        case TimeoutException _:
          _message = "Connection timeout with API server";
          snackBarHandler(_message);
          break;
        case FormatException _:
          if (exception.message == 'Invalid token') {
            ContextlessPopups().singoutPopup();
          }
          break;
        default:
          _message = "Something went wrong";
          break;
      }
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => _message;
}
