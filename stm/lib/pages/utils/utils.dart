import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class bgWidget extends StatelessWidget {
  final String bgImage;
  final Color? overlayColor;
  final Widget child;
  const bgWidget({
    required this.bgImage,
    required this.child,
    this.overlayColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.fill,
          ),
          color: Colors.black,
        ),
        child: Container(
          height: size.height,
          width: size.width,
          color: overlayColor,
          child: child,
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

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SfCartesianChart(
        title: ChartTitle(
          text: "Time spend (in minutes)",
          textStyle: GoogleFonts.oswald(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<dynamic, String>>[
          BarSeries<dynamic, String>(
            dataSource: data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: 'Minutes',
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}

class GridCards extends StatelessWidget {
  GridCards({
    Key? key,
    required this.data,
  }) : super(key: key) {}

  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        // physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
        ),
        itemBuilder: (ctx, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(color: Colors.red, width: 3),
          ),
          child: ListTile(
            leading: Icon(
              Icons.wordpress,
              size: 20,
            ),
            title: Text(data[index].x),
            subtitle: Text(data[index].y.toString() + " min"),
            iconColor: Colors.black,
            minLeadingWidth: 20,
          ),
        ),
      ),
    );
  }
}
