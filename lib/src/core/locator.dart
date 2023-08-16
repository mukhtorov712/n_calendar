import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:n_calendar/src/features/calendar/calendar_di.dart';

import 'constants/app_constants.dart';
import 'interceptors/api_interceptor.dart';

final GetIt locator = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio Client
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        contentType: "application/json; charset=UTF-8",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60 * 1000),
        receiveTimeout: const Duration(seconds: 60 * 1000),
        listFormat: ListFormat.multiCompatible,
      ),
    )..interceptors.addAll([ApiInterceptor()]),
    // way of adding interceptors and ect.  ->   ..interceptors.addAll([]),
  );

  calendarDI();
}
