import 'package:dio/dio.dart';

import '../services/services.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    LogService.request(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    LogService.response(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
    //   rootNavigator.currentContext?.pushNamed(AppRoutes.register.name);
    // }
    LogService.errorResponse(err);
    super.onError(err, handler);
  }
}
