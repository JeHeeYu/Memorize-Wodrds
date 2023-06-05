import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleDialog {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Container(
            child: Column(
              children: [
                TableCalendar(
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      if (day.weekday == DateTime.sunday) {
                        return const Center(
                          child: Text(
                            '일',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      if (day.weekday == DateTime.saturday) {
                        return const Center(
                          child: Text(
                            '토',
                            style: TextStyle(color: Colors.blue),
                          ),
                        );
                      }
                    },
                  ),
                  locale: 'ko-KR',
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2023),
                  lastDay: DateTime(3000),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  calendarStyle: const CalendarStyle(
                    isTodayHighlighted: true,
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
