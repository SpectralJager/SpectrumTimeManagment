import 'package:get/get.dart';
import 'package:stm/models/database/taskStore.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/taskpage.dart';

class TaskController extends GetxController {
  late Task task;
  var _store = TaskStore();

  @override
  void onInit() {
    super.onInit();
    this._store.init(db_name: "stm.db");
  }

  void findTask(int id) async {
    this.task = await this._store.fetchTask(id);
    Get.off(() => Taskpage());
  }
}
