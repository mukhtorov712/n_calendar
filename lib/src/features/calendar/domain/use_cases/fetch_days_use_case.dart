import 'package:n_calendar/src/features/calendar/data/models/days_model.dart';

import '../../../../../../src/features/calendar/domain/repositories/calendar_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/use_case.dart';

class FetchDaysUseCase implements UseCase<DataState<DaysModel>, dynamic> {
  final CalendarRepository _repository;

  FetchDaysUseCase(this._repository);

  @override
  Future<DataState<DaysModel>> call({dynamic params}) async => await _repository.fetchDays();
}
