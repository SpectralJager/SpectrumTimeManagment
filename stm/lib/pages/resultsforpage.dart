import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/utils/drawer.dart';
import 'package:table_calendar/table_calendar.dart';

class ResultsForPage extends StatelessWidget {
  const ResultsForPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();

    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        backgroundColor: AppCtr.appBarBgColor,
        title: Text('Выберети дату'),
      ),
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          onDaySelected: (selectedDay, focusedDay) {
            AppCtr.GenerateResults(selectedDay);
          },
        ),
      ),
    );
  }
}
