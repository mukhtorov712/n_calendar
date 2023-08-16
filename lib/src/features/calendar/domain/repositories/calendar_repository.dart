import 'package:n_calendar/src/features/calendar/data/models/days_model.dart';
import 'package:n_calendar/src/features/calendar/data/models/enum_model.dart';

import '../../../../core/resources/data_state.dart';

abstract class CalendarRepository {
  Future<DataState<DaysModel>> fetchDays();

  Future<DataState<List<EnumModel>>> fetchEnums();
}
