import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:n_calendar/src/features/calendar/data/models/days_model.dart';
import 'package:n_calendar/src/features/calendar/data/models/enum_model.dart';
import 'package:n_calendar/src/features/calendar/domain/use_cases/fetch_days_use_case.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/fetch_enums_use_case.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final FetchDaysUseCase _fetchDaysUseCase;
  final FetchEnumsUseCase _fetchEnumsUseCase;

  CalendarBloc(
    this._fetchDaysUseCase,
    this._fetchEnumsUseCase,
  ) : super(CalendarState()) {
    on<FetchEnumsEvent>((event, emit) async {
      await emit.onEach(_onFetchEnums(event), onData: emit);
    });
    on<FetchDaysEvent>((event, emit) async {
      await emit.onEach(_onFetchDays(event), onData: emit);
    });
  }

  init() {
    fetchEnums();
    fetchDays();
  }

  fetchEnums() {
    add(FetchEnumsEvent());
  }

  Stream<CalendarState> _onFetchEnums(FetchEnumsEvent event) async* {
    yield state.copyWith(status: CalendarStatus.loading);

    final dataState = await _fetchEnumsUseCase.call();

    if (dataState is DataSuccess) {
      yield state.copyWith(enumList: dataState.data);
    } else if (dataState is DataFailed) {
      yield state.copyWith(status: CalendarStatus.error, errorMessage: dataState.message);
    }
  }

  fetchDays() {
    add(FetchDaysEvent());
  }

  Stream<CalendarState> _onFetchDays(FetchDaysEvent event) async* {
    yield state.copyWith(status: CalendarStatus.loading);

    final dataState = await _fetchDaysUseCase.call();

    if (dataState is DataSuccess) {
      yield state.copyWith(status: CalendarStatus.success, daysModel: dataState.data);
    } else if (dataState is DataFailed) {
      yield state.copyWith(status: CalendarStatus.error, errorMessage: dataState.message);
    }
  }
}
