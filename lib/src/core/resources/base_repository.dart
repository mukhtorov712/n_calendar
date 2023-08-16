import 'package:dio/dio.dart';
import 'package:n_calendar/src/core/constants/app_constants.dart';
import 'package:n_calendar/src/core/extensions/dio_error.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

import 'data_state.dart';

mixin BaseRepository {
  Future<DataState<T>> handleResponse<T>(
      {required Future<retrofit.HttpResponse<T>> response, T Function(T param)? next}) async {
    try {
      final httpResponse = await response;
      return DataSuccess(next == null ? httpResponse.data : next((httpResponse.data)));
    } on DioException catch (e) {
      if (e.isNoConnection || e.isBadConnection) {
        return const DataFailed(message: AppConstants.badInternetConnection);
      } else if (e.isBadRequest) {
        String message = e.response?.data?['detail'] ?? 'Bad request';
        return DataFailed(message: message);
      } else {
        return const DataFailed(message: AppConstants.appError);
      }
    }
  }
}
