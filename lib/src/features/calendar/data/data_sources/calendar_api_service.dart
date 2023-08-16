import 'package:n_calendar/src/features/calendar/data/models/days_model.dart';
import 'package:n_calendar/src/features/calendar/data/models/enum_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'calendar_api_service.g.dart';

@RestApi()
abstract class CalendarApiService {
  factory CalendarApiService(Dio dio, {String baseUrl}) = _CalendarApiService;

  /// URLS
  static const String _days = '92TT';
  static const String _enums = 'I86U';

  /// REQUESTS

  @GET(_days)
  Future<HttpResponse<DaysModel>> fetchDays();

  @GET(_enums)
  Future<HttpResponse<List<EnumModel>>> fetchEnums();
}
