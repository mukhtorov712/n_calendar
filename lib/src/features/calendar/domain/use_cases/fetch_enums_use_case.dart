import 'package:n_calendar/src/features/calendar/data/models/enum_model.dart';

import '../../../../../../src/features/calendar/domain/repositories/calendar_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/use_case.dart';

class FetchEnumsUseCase implements UseCase<DataState<List<EnumModel>>, dynamic> {
  final CalendarRepository _repository;

  FetchEnumsUseCase(this._repository);

  @override
  Future<DataState<List<EnumModel>>> call({dynamic params}) async => await _repository.fetchEnums();
}
