import 'dart:async';

import 'package:get/get.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';
import 'package:stm/utils/Categories.dart';

class taskController extends GetxController {
  var task = Task(name: "", category: Categories.Other);
  var td = "".obs;
  var tempPhase;

  void addPhase(Phase phase) {
    this.task.phases.add(phase);
    update();
  }

  void timeDiff() {
    td.value = tempPhase.startTime.difference(DateTime.now()).toString();
  }
}
