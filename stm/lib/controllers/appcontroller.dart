import 'package:get/get.dart';
import 'package:stm/models/task.dart';
import 'package:stm/utils/Categories.dart';

class appController extends GetxController {
  List<Task> tasks = [
    Task(name: "First", category: Categories.Sport),
    Task(name: "Second", category: Categories.Work),
    Task(name: "Third", category: Categories.Work),
    Task(name: "Fourth", category: Categories.Other),
  ].obs;

  void addTask(Task newTask) {
    tasks.add(newTask);
    update();
  }
}
