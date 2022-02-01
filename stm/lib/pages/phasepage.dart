import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/taskcontroller.dart';
import 'package:stm/models/phase.dart';

class Phasepage extends StatelessWidget {
  const Phasepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    taskController taskCtrl = Get.find<taskController>();
    var phase =
        Phase(index: taskCtrl.task.phases.length, startTime: DateTime.now());
    taskCtrl.tempPhase = phase;
    var timer =
        Timer.periodic(Duration(seconds: 1), (_) => taskCtrl.timeDiff());
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: GetBuilder<taskController>(builder: (_) {
        return FloatingActionButton(
          child: Icon(Icons.send_sharp),
          onPressed: () {
            phase.ChangeEndTime = DateTime.now();
            timer.cancel();
            taskCtrl.addPhase(phase);
            Get.back();
          },
        );
      }),
      body: Center(
        child: Obx(
          () => Text(taskCtrl.td.value),
        ),
      ),
    );
  }
}
