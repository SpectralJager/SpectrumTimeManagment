import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stm/models/phase.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  late Task task;
  late Phase newPhase;

  // TaskController({required this.task});

  set changeName(String name) {
    this.task = this.task.copyWith(name: name);
    this.update();
  }

  set changeBgColor(Color color) {
    this.task = this.task.copyWith(bgColor: color);
    this.update();
  }

  void addPhase() async {
    this.task.phases.add(this.newPhase);
    this.update();
    Get.back();
  }

  String phaseTime(Phase phase) {
    return "${DateFormat('MM.dd, kk:mm').format(phase.startTime)} to ${DateFormat('MM.dd, kk:mm').format(phase.endTime)}";
  }

  String phaseDuration(Phase phase) {
    var duration = phase.endTime.difference(phase.startTime);
    return "${duration.inMinutes} minutes";
  }
}
