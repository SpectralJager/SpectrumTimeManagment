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
        Phase(index: taskCtrl.phases.value.length, startTime: DateTime.now());
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send_sharp),
        onPressed: () {
          phase.ChangeEndTime = DateTime.now();
          taskCtrl.addPhase(phase);
          print(phase.toString());
          Get.back();
        },
      ),
    );
  }
}
