import "package:n_calendar/src/features/calendar/domain/use_cases/fetch_days_use_case.dart";
import "package:n_calendar/src/features/calendar/domain/use_cases/fetch_enums_use_case.dart";

import "../../core/locator.dart";
import "data/data_sources/calendar_api_service.dart";
import "data/repositories/calendar_repository_impl.dart";
import "domain/repositories/calendar_repository.dart";
import "presentation/manager/calendar_bloc.dart";

Future<void> calendarDI() async {
  // DataSources
  locator.registerSingleton(CalendarApiService(locator()));

  // Repositories
  locator.registerSingleton<CalendarRepository>(CalendarRepositoryImpl(locator()));

  // UseCases
  locator.registerSingleton(FetchDaysUseCase(locator()));
  locator.registerSingleton(FetchEnumsUseCase(locator()));

  // Blocs
  locator.registerFactory<CalendarBloc>(() => CalendarBloc(locator(), locator()));
}
