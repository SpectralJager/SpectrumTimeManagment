import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stm/models/phase.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  late Task task;
  late Phase newPhase;
  var td = '00:00:00'.obs;

  // TaskController({required this.task});

  set changeName(String name) {
    this.task = this.task.copyWith(name: name);
  }

  set changeBgColor(Color color) {
    this.task = this.task.copyWith(bgColor: color);
    this.update();
  }

  set changeTxtColor(Color color) {
    this.task = this.task.copyWith(txtColor: color);
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

  void timeDiff() {
    var duration = DateTime.now().difference(this.newPhase.startTime);
    td.value =
        "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
