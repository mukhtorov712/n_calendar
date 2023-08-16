import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:n_calendar/src/core/components/app_progress.dart';
import 'package:n_calendar/src/core/extensions/empty_padding.dart';

import '../manager/calendar_bloc.dart';
import '../widgets/custom_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime date = DateTime.now();
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color: color.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(DateFormat("dd.MM.yyyy").format(date),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          if (state.status == CalendarStatus.loading) 8.pw,
                          if (state.status == CalendarStatus.loading) const AppProgress(size: 20),
                        ],
                      ),
                    ),
                  ),
                  16.ph,
                  Theme(
                    data: Theme.of(context).copyWith(
                      datePickerTheme: const DatePickerThemeData(
                          weekdayStyle: TextStyle(color: Color(0xFF6C7072), fontSize: 12),
                          dayStyle: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CustomCalendar(
                        onChanged: (value) {
                          setState(() {
                            date = value.date;
                            color = value.color;
                          });
                        },
                        year: state.daysModel?.year?.toInt() ?? date.year,
                        month: int.parse(state.daysModel?.month ?? "${date.month}"),
                        markedDayList: state.daysModel?.day ?? [],
                        enumList: state.enumList,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
