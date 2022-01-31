import 'package:get/get.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';
import 'package:stm/utils/Categories.dart';

class taskController extends GetxController {
  var task = Task(name: "", category: Categories.Other);
  var phases = Rx<List<Phase>>([]);

  void addPhase(Phase phase) {
    phases.value.add(phase);
    this.task.phases.add(phase);
    print(phases.value.toString());
    update();
  }
}
