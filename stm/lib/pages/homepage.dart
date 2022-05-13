import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/utils/drawer.dart';
import 'package:stm/pages/utils/homebody.dart';
import 'package:stm/pages/utils/hometopcalendar.dart';
import 'package:stm/pages/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (ctr) {
        return Scaffold(
          drawer: drawer,
          floatingActionButton: Builder(builder: (context) {
            return drawerFAB(context: context);
          }),
          body: bgWidget(
            bgImage: "assets/images/bg.jpg",
            overlayColor: Colors.black54,
            child: Column(
              children: [
                HomeTopCalendar(
                  selectedDay: ctr.selectedDay,
                  onDaySelected: (selected, _) {
                    ctr.fetchSelectedDayTasks(selected);
                  },
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.white,
                ),
                ctr.dayTasks.length == 0
                    ? NothingWidget()
                    : HomeBody(
                        results: ctr.dayTasks,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
