import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sembast/sembast_io.dart';
import 'package:stm/models/categorydata.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/loadingpage.dart';
import 'package:stm/utils/Categories.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:path_provider/path_provider.dart';

class AppController extends GetxController {
  List<Task> tasks = [];
  List<CategoryData> categoryData = [];
  late Task editedTask;
  late Phase newPhase;
  late Database _database;
  late StoreRef _store;
  var td = '00:00:00'.obs;

  @override
  void onInit() async {
    super.onInit();
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "stm.db");
    this._database = await databaseFactoryIo.openDatabase(databasePath);
    Get.snackbar("database open/created succesfully!", '');
    this._store = intMapStoreFactory.store("tasks_store");
    this.fetchTasks();
    await Future.delayed(
      Duration(seconds: 5),
      () {},
    );
    Get.off(() => Homepage());
  }

  void fetchTasks() async {
    final snapshot = await this._store.find(this._database);
    print('fetch ${DateTime.now()}');
    this.tasks = snapshot
        .map((element) => Task.fromMap(element.key, element.value))
        .toList();
    this.update();
  }

  void addTask() async {
    Get.off(() => LoadingPage());
    if (this.editedTask.id == 0) {
      await this._store.add(this._database, this.editedTask.toMap());
    } else {
      await this
          ._store
          .record(this.editedTask.id)
          .update(this._database, this.editedTask.toMap());
    }
    this.fetchTasks();
    await Future.delayed(
      Duration(seconds: 2),
      () {},
    );
    // print('add ${DateTime.now()}');
    Get.back();
  }

  void deleteTask() async {
    Get.off(() => LoadingPage());
    await this._store.record(this.editedTask.id).delete(this._database);
    this.fetchTasks();
    await Future.delayed(
      Duration(seconds: 2),
      () {},
    );
    Get.back();
  }

  void addPhase() async {
    this.editedTask.phases.add(this.newPhase);
    this.addTask();
    this.update();
  }

  void generateCategoryDataList() {
    var currentTime = DateTime.now();
    var twentyFourHoursAgo = currentTime.subtract(Duration(hours: 24));
    var durationAtAll = Duration();
    var duration = Duration();
    this.categoryData = Categories.values.map<CategoryData>((category) {
      durationAtAll += duration;
      // print(durationAtAll);
      duration = Duration();
      for (int i = 0; i < this.tasks.length; i++) {
        if (this.tasks[i].category != category) {
          continue;
        }
        for (int j = 0; j < this.tasks[i].phases.length; j++) {
          var phase = this.tasks[i].phases[j];
          if (phase.startTime.isBefore(twentyFourHoursAgo) &&
              phase.endTime.isAfter(twentyFourHoursAgo)) {
            duration += phase.endTime.difference(twentyFourHoursAgo);
          } else if (phase.startTime.isAfter(twentyFourHoursAgo) &&
              phase.endTime.isBefore(currentTime)) {
            duration += phase.endTime.difference(phase.startTime);
          }
        }
      }
      // print("${category.name}:${duration.inMinutes}");
      return CategoryData(category: category, duration: duration);
    }).toList();
    this.categoryData.last.duration += Duration(hours: 24) - durationAtAll;
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
