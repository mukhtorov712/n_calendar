import 'dart:io';

import 'package:dio/dio.dart';

extension DioErrorX on DioException {
  bool get isBadConnection => type == DioExceptionType.connectionTimeout;

  bool get isNoConnection => type == DioExceptionType.unknown && error is SocketException;

  bool get isBadRequest => (400 <= (response?.statusCode ?? 499) && (response?.statusCode ?? 499) < 500);
}

extension ResponceX on Response {
  bool get isSuccessful => (200 <= (statusCode ?? 499) && (statusCode ?? 499) < 300);
}
