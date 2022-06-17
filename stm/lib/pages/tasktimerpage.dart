import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/controlers/timercontroller.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';

import 'utils/drawer.dart';
import 'utils/utils.dart';

class TaskTimerPage extends GetView<TimerController> {
  TaskTimerPage({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  Widget build(BuildContext context) {
    Get.put<TimerController>(TimerController());
    var appController = Get.find<AppController>();
    var newPhase = Phase(
      description: '',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
    );
    controller.newPhase = newPhase;
    var timer =
        Timer.periodic(Duration(seconds: 1), (timer) => controller.timeDiff());

    return Scaffold(
      drawer: drawer,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            heroTag: null,
            onPressed: () {
              timer.cancel();
              task.phases.add(newPhase);
              appController.saveTask(task);
            },
            child: const Icon(
              Icons.stop,
              color: Colors.white,
              size: 28,
            ),
            backgroundColor: Colors.red,
          );
        },
      ),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.size.width,
              height: Get.size.width,
              padding: EdgeInsets.all(40),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RotationTransition(
                    turns: appController.animation,
                    child: SvgPicture.asset(
                      'assets/images/start_btn_bg.svg',
                      width: Get.size.width,
                      height: Get.size.width,
                      color: Colors.redAccent,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/timer_tree.svg',
                  ),
                ],
              ),
            ),
            Container(
              width: Get.size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: GetBuilder<TimerController>(builder: (_) {
                var timer = _.td.split(':');
                var headers = [
                  'hours',
                  'minutes',
                  'seconds',
                ];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < timer.length; i++)
                      Container(
                        width: 110,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              timer[i],
                              style: GoogleFonts.montserrat(
                                color: Colors.redAccent,
                                fontSize: 64,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              headers[i].toUpperCase(),
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
