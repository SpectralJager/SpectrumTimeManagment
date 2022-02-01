import 'package:get/get.dart';
import 'package:stm/models/task.dart';
import 'package:stm/utils/Categories.dart';

class appController extends GetxController {
  var tasks = [];

  void addTask(Task newTask) {
    tasks.add(newTask);
    update();
  }
}
