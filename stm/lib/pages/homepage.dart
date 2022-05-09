import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:sembast/sembast.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/models/result.dart';
import 'package:stm/pages/taskpage.dart';
import 'package:stm/pages/utils/drawer.dart';
import 'package:stm/pages/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends GetView<AppController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (ctr) {
        return Scaffold(
          drawer: drawer,
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              heroTag: null,
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: const Icon(
                Icons.apps,
                color: Colors.white,
                size: 28,
              ),
              backgroundColor: Colors.red,
            );
          }),
          body: bgWidget(
            bgImage: "assets/images/bg.jpg",
            overlayColor: Colors.black54,
            child: Column(
              children: [
                Container(
                  color: Colors.black87,
                  child: TableCalendar(
                    firstDay: DateTime.now().subtract(Duration(days: 365)),
                    lastDay: DateTime.now().add(Duration(days: 365)),
                    focusedDay: ctr.selectedDay,
                    selectedDayPredicate: (date) {
                      return isSameDay(ctr.selectedDay, date);
                    },
                    onDaySelected: (selected, focused) {
                      ctr.fetchNDayTasks(selected);
                    },
                    calendarFormat: CalendarFormat.week,
                    availableCalendarFormats: const <CalendarFormat, String>{
                      CalendarFormat.week: "week",
                    },
                    headerStyle: HeaderStyle(
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
                        color: Colors.yellowAccent,
                        shape: BoxShape.rectangle,
                      ),
                      selectedTextStyle: GoogleFonts.openSans(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.white,
                ),
                ctr.dayTasks.length == 0
                    ? Column(
                        children: [
                          Container(
                            width: Get.size.width,
                            height: Get.size.width,
                            child: RiveAnimation.asset('assets/nothing.riv'),
                          ),
                          Text(
                            'Nothing...',
                            style: GoogleFonts.oswald(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              letterSpacing: 6,
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: ctr.dayTasks.length + 1,
                          itemBuilder: (ctx, index) {
                            if (index == 0) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: const Radius.circular(20),
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
                                  primaryYAxis:
                                      NumericAxis(minimum: 0, interval: 10),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: [
                                    BarSeries<Result, String>(
                                      dataSource: ctr.dayTasks,
                                      xValueMapper: (Result data, _) =>
                                          data.title,
                                      yValueMapper: (Result data, _) =>
                                          data.time,
                                      name: 'Minutes',
                                      pointColorMapper: (Result data, _) =>
                                          data.bgColor,
                                      sortFieldValueMapper: (data, _) =>
                                          data.time,
                                      sortingOrder: SortingOrder.ascending,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              var item = ctr.dayTasks[index - 1];
                              return GestureDetector(
                                onTap: (() =>
                                    Get.to(() => TaskPage(task: item.task))),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: item.bgColor,
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: item.bgColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            item.title[0].toUpperCase(),
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            style: GoogleFonts.oswald(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            item.subtitle,
                                            style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
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
