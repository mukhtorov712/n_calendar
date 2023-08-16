import 'package:n_calendar/src/features/calendar/data/models/days_model.dart';
import 'package:n_calendar/src/features/calendar/data/models/enum_model.dart';

import '../../../../core/resources/base_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../data_sources/calendar_api_service.dart';

class CalendarRepositoryImpl with BaseRepository implements CalendarRepository {
  final CalendarApiService _apiService;

  CalendarRepositoryImpl(this._apiService);

  @override
  Future<DataState<DaysModel>> fetchDays() async => await handleResponse(response: _apiService.fetchDays());

  @override
  Future<DataState<List<EnumModel>>> fetchEnums() async => await handleResponse(response: _apiService.fetchEnums());
}
