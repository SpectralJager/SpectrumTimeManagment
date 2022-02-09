import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/models/phase.dart';

class PhasePage extends StatelessWidget {
  const PhasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController ctr = Get.find<AppController>();
    ctr.newPhase = Phase(
        index: ctr.editedTask.phases.length,
        startTime: DateTime.now(),
        endTime: DateTime.now());
    var timer = Timer.periodic(Duration(seconds: 1), (_) => ctr.timeDiff());
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send_sharp),
        onPressed: () {
          timer.cancel();
          ctr.newPhase.endTime = DateTime.now();
          ctr.addPhase();
        },
      ),
      body: Center(
        child: Obx(
          () => Text(ctr.td.value),
        ),
      ),
    );
  }
}
