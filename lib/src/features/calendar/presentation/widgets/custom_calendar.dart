import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../../../core/utils/hex_color.dart';
import '../../data/models/days_model.dart';
import '../../data/models/enum_model.dart';

typedef CallbackData = ({DateTime date, Color color});

const double _dayPickerRowHeight = 64.0;

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    super.key,
    required this.year,
    required this.month,
    required this.markedDayList,
    required this.enumList,
    required this.onChanged,
  });

  final int year;
  final int month;
  final List<DayModel> markedDayList;
  final List<EnumModel> enumList;

  final ValueChanged<CallbackData> onChanged;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  int selectDay = -1;

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final DatePickerThemeData datePickerTheme = DatePickerTheme.of(context);
    final DatePickerThemeData defaults = DatePickerTheme.defaults(context);
    final TextStyle? weekdayStyle = datePickerTheme.weekdayStyle ?? defaults.weekdayStyle;
    final TextStyle? dayStyle = datePickerTheme.dayStyle ?? defaults.dayStyle;

    final int daysInMonth = DateUtils.getDaysInMonth(widget.year, widget.month);
    final int dayOffset = DateUtils.firstDayOffset(widget.year, widget.month, localizations);

    ///Add Weekday Header
    final List<Widget> dayItems = _dayHeaders(weekdayStyle, localizations);

    int day = -dayOffset;
    while (day < daysInMonth) {
      day++;
      if (day < 1) {
        dayItems.add(Container());
      } else {
        final dayToBuild = DateTime(widget.year, widget.month, day);
        var dayModel = widget.markedDayList.firstWhereOrNull((e) => e.day == day);
        var color = HexColor(widget.enumList.firstWhereOrNull((e) => e.type == dayModel?.type)?.color ?? "#FFFFFF");

        Widget dayWidget = InkResponse(
          onTap: () {
            widget.onChanged((date: dayToBuild, color: color));
            selectDay = dayToBuild.day;
            setState(() {});
          },
          radius: _dayPickerRowHeight / 2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: dayModel != null ? color : Colors.transparent,
              border: day == selectDay ? Border.all(width: 1, color: Colors.black) : null,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                localizations.formatDecimal(day),
                style: dayStyle?.apply(
                  color: dayModel != null
                      ? color.computeLuminance() > 0.8
                          ? Colors.black
                          : Colors.white
                      : dayToBuild.weekday % 7 == 0
                          ? Colors.red
                          : dayStyle.color,
                ),
              ),
            ),
          ),
        );

        dayItems.add(dayWidget);
      }
    }

    return GridView.custom(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: _gridDelegate,
      childrenDelegate: SliverChildListDelegate(
        dayItems,
        addRepaintBoundaries: false,
      ),
    );
  }

  List<Widget> _dayHeaders(TextStyle? headerStyle, MaterialLocalizations localizations) {
    final List<Widget> result = <Widget>[];
    for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      result.add(
        ExcludeSemantics(
          child: Center(
            child: Text(
              DateFormat().dateSymbols.WEEKDAYS[i].substring(0, 3),
              style: headerStyle?.apply(color: i == 0 ? Colors.red : headerStyle.color),
            ),
          ),
        ),
      );
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) {
        break;
      }
    }
    return result;
  }
}

class CustomCalendarGridDelegate extends SliverGridDelegate {
  const CustomCalendarGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double tileHeight = math.min(
      _dayPickerRowHeight,
      constraints.viewportMainAxisExtent / 7,
    );
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(CustomCalendarGridDelegate oldDelegate) => false;
}

const CustomCalendarGridDelegate _gridDelegate = CustomCalendarGridDelegate();
