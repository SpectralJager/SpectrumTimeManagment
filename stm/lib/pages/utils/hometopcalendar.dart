import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeTopCalendar extends StatelessWidget {
  HomeTopCalendar({
    required this.selectedDay,
    required this.onDaySelected,
    Key? key,
  }) : super(key: key);
  // Parameters
  DateTime selectedDay;
  Function(DateTime, DateTime) onDaySelected;

  // Styles
  final headerStyle = HeaderStyle(
    titleTextStyle: GoogleFonts.oswald(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    titleCentered: true,
    leftChevronIcon: const Icon(
      Icons.chevron_left_rounded,
      color: Colors.white,
      size: 28,
    ),
    rightChevronIcon: const Icon(
      Icons.chevron_right_rounded,
      color: Colors.white,
      size: 28,
    ),
  );

  final daysOfWeekStyle = DaysOfWeekStyle(
    weekdayStyle: GoogleFonts.openSans(
      color: Colors.white70,
      fontWeight: FontWeight.w900,
    ),
    weekendStyle: GoogleFonts.openSans(
      color: Colors.red.shade700,
      fontWeight: FontWeight.w900,
    ),
  );

  final calendarStyle = CalendarStyle(
    defaultTextStyle:
        GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.w500),
    weekendTextStyle: GoogleFonts.openSans(
        color: Colors.redAccent, fontWeight: FontWeight.bold),
    todayTextStyle: GoogleFonts.openSans(
      color: Colors.black,
      fontWeight: FontWeight.w900,
    ),
    todayDecoration: BoxDecoration(
      color: Color(
        Colors.white.hashCode,
      ),
      shape: BoxShape.rectangle,
    ),
    selectedDecoration: BoxDecoration(
      color: Colors.yellowAccent,
      shape: BoxShape.rectangle,
    ),
    selectedTextStyle:
        GoogleFonts.openSans(color: Colors.black, fontWeight: FontWeight.bold),
  );

  // Methods
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: TableCalendar(
        firstDay: DateTime.now().subtract(Duration(days: 365)),
        lastDay: DateTime.now().add(Duration(days: 365)),
        focusedDay: this.selectedDay,
        selectedDayPredicate: (date) {
          return isSameDay(this.selectedDay, date);
        },
        onDaySelected: (selected, focused) =>
            this.onDaySelected(selected, focused),
        calendarFormat: CalendarFormat.week,
        availableCalendarFormats: const <CalendarFormat, String>{
          CalendarFormat.week: "week",
        },
        headerStyle: headerStyle,
        daysOfWeekStyle: daysOfWeekStyle,
        calendarStyle: calendarStyle,
      ),
    );
  }
}
