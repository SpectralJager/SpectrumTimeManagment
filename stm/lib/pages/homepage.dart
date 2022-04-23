import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/pages/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black26,
        child: Column(
          children: [
            Calendar(),
          ],
        ),
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.week,
        availableCalendarFormats: <CalendarFormat, String>{
          CalendarFormat.week: "week",
        },
        headerStyle: HeaderStyle(
          titleTextStyle: GoogleFonts.oswald(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
            size: 28,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.openSans(
            color: Colors.white70,
            fontWeight: FontWeight.w900,
          ),
          weekendStyle: GoogleFonts.openSans(
            color: Colors.red.shade700,
            fontWeight: FontWeight.w900,
          ),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: GoogleFonts.openSans(
              color: Colors.white, fontWeight: FontWeight.w500),
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
            color: Color(
              Colors.yellow.hashCode,
            ),
            shape: BoxShape.rectangle,
          ),
          selectedTextStyle: GoogleFonts.openSans(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
