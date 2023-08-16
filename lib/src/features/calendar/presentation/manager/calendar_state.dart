part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loading, success, error }

class CalendarState {
  final DaysModel? daysModel;
  final List<EnumModel> enumList;
  final CalendarStatus status;
  final String errorMessage;

  CalendarState({
    this.daysModel,
    this.enumList = const [],
    this.status = CalendarStatus.initial,
    this.errorMessage = 'Some Error',
  });

  CalendarState copyWith({
    DaysModel? daysModel,
    List<EnumModel>? enumList,
    CalendarStatus? status,
    String? errorMessage,
  }) =>
      CalendarState(
        daysModel: daysModel ?? this.daysModel,
        enumList: enumList ?? this.enumList,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
