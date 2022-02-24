import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/models/categorydata.dart';
import 'package:stm/models/database/taskStore.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/indexpage.dart';
import 'package:stm/utils/Categories.dart';

class AppController extends GetxController {
  List<Task> tasks = [];
  List<List<CategoryData>> categoryData = [
    [],
    [],
    [],
  ];
  var _pageIndex = 0.obs;
  var _slideIndex = 0;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  final TaskStore _task_store = TaskStore();
  // var td = '00:00:00'.obs;

  @override
  void onInit() async {
    super.onInit();
    // if (await Permission.storage.request().isDenied) {
    //   exit(0);
    // }
    this._task_store.init(db_name: "stm.db");
    this.getTasks();
    this.generateCategoryDataList();

    await Future.delayed(Duration(seconds: 3), () => null);
    Get.off(() => Index());
  }

  int get pageIndex => this._pageIndex.value;
  set pageIndex(int index) {
    this._pageIndex.value = index;
    this.pageController.animateToPage(this.pageIndex,
        duration: Duration(milliseconds: 100), curve: Curves.ease);
  }

  int get slideIndex => this._slideIndex;
  set slideIndex(int index) {
    this._slideIndex = index;
    this.update();
  }

  void getTasks() async {
    this.tasks = await this._task_store.fetchTasks();
    print(tasks);
    // this.tasks = [
    //   Task(
    //       id: 1, name: "test1", category: Categories.entertainment, phases: []),
    //   Task(id: 2, name: "test2", category: Categories.work, phases: []),
    // ];
  }

  void generateCategoryDataList() {
    var currentTime = DateTime.now();
    var timeInt = [
      24,
      24 * 7,
      24 * 30,
    ];
    var timeDiff = [
      currentTime.subtract(Duration(hours: 24)),
      currentTime.subtract(Duration(days: 7)),
      currentTime.subtract(Duration(days: 30)),
    ];
    var durationAtAll, duration = Duration();
    for (int i = 0; i < 3; i++) {
      durationAtAll = Duration();
      this.categoryData[i] = Categories.values.map<CategoryData>((category) {
        durationAtAll += duration;
        duration = Duration();
        for (int i = 0; i < this.tasks.length; i++) {
          if (this.tasks[i].category != category) {
            continue;
          }
          for (int j = 0; j < this.tasks[i].phases.length; j++) {
            var phase = this.tasks[i].phases[j];
            if (phase.start_time.isBefore(timeDiff[i]) &&
                phase.end_time.isAfter(timeDiff[i])) {
              duration += phase.duration(start_point: timeDiff[i]);
            } else if (phase.start_time.isAfter(timeDiff[i]) &&
                phase.end_time.isBefore(currentTime)) {
              duration += phase.duration();
            }
          }
        }
        return CategoryData(category: category, duration: duration);
      }).toList();
      this.categoryData[i].last.duration +=
          Duration(hours: timeInt[i]) - durationAtAll;
    }
  }

  // void timeDiff() {
  //   var duration = DateTime.now().difference(this.newPhase.startTime);
  //   td.value =
  //       "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  // }
}
