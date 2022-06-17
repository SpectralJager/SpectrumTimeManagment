import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stm/models/phase.dart';

import '../models/task.dart';

class TaskController extends GetxController with GetTickerProviderStateMixin {
  late Task task;
  late TextEditingController nameFieldController;
  late TextEditingController descriptionFieldController;

  set changeName(String name) {
    this.task = this.task.copyWith(name: name);
    // this.update();
  }

  set changeDescription(String description) {
    this.task = this.task.copyWith(description: description);
    // this.update();
  }

  set changeBgColor(Color color) {
    this.task = this.task.copyWith(bgColor: color);
    this.update();
  }

  void deletePhase(Phase phase) {
    var phases = this.task.phases;
    phases.remove(phase);
    this.task = this.task.copyWith(phases: phases);
  }

  String phaseTime(Phase phase) {
    return "${DateFormat('dd MMM, kk:mm').format(phase.startTime)} - ${DateFormat('dd MMM, kk:mm').format(phase.endTime)}";
  }

  String phaseDuration(Phase phase) {
    var duration = phase.endTime.difference(phase.startTime);
    return "${duration.inMinutes} minutes";
  }
}
