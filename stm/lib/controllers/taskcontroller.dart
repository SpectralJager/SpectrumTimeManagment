import 'package:get/get.dart';
import 'package:stm/models/database/taskStore.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/splashpage.dart';
import 'package:stm/pages/taskpage.dart';
import 'package:stm/utils/Categories.dart';

class TaskController extends GetxController {
  late Task task;
  late Phase phase;
  var td = '00:00:00'.obs;
  var _store = TaskStore();

  @override
  void onInit() {
    super.onInit();
    this._store.init(db_name: "stm.db");
  }

  void createTask() {
    this.task = Task(id: 0, name: "", category: Categories.other, phases: []);
  }

  void findTask(int id) async {
    this.task = await this._store.fetchTask(id);
    Get.off(() => Taskpage());
  }

  void addTask() async {
    this._store.addTask(this.task);
  }

  void editTask() async {
    this._store.editTask(this.task);
  }

  void addPhase() {
    Get.off(() => SplashPage());
    this.task = this.task.copyWith(phases: this.task.phases + [this.phase]);
    if (this.task.id == 0) {
      this.addTask();
    } else {
      this.editTask();
    }
    this.update();
    Get.back();
  }

  void timeDiff() {
    var duration = this.phase.duration(end_point: DateTime.now());
    this.td.value =
        "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
