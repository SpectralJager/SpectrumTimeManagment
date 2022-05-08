import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:stm/models/result.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/loadingpage.dart';

class AppController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  List<Task> allTasks = [];
  List<Result> dayTasks = [];

  DateTime selectedDay = DateTime.now();

  late Database _db;
  late StoreRef _taskStore;

  @override
  void onInit() async {
    super.onInit();
    if (await Permission.storage.request().isDenied) {
      exit(0);
    }
    this.initAnimation();
    await this.initDB();
    await this.fetchTasks();
    Get.off(() => HomePage());
  }

  void initAnimation() {
    this._controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
      value: 0.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    this.animation =
        CurvedAnimation(parent: this._controller, curve: Curves.linear);
    this._controller.repeat(reverse: false);
  }

  Future initDB() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "stm.db");
    this._db = await databaseFactoryIo.openDatabase(databasePath);
    log("database open/created succesfully!");
    this._taskStore = intMapStoreFactory.store("tasks_store");
    log("task store open/created succesfully!");
    return Future.delayed(Duration(seconds: 1));
  }

  Future fetchTasks() async {
    final snapshot = await this._taskStore.find(this._db);
    this.allTasks = snapshot
        .map((element) => Task.fromMap(element.key, element.value))
        .toList();
    this.update();
    return Future.delayed(Duration(seconds: 2));
  }

  Future saveTask(Task task) async {
    Get.off(() => LoadingPage());
    if (task.id == 0) {
      await this._taskStore.add(this._db, task.toMap());
    } else {
      await this._taskStore.record(task.id).update(this._db, task.toMap());
    }
    await this.fetchTasks();
    Get.back();
  }

  Future deleteTask(Task task) async {
    Get.off(() => LoadingPage());
    await this._taskStore.record(task.id).delete(this._db);
    await this.fetchTasks();
    Get.back();
  }

  void fetchNDayTasks(DateTime date) {
    this.selectedDay = date;
    this.dayTasks = [];
    this.allTasks.forEach(
      (task) {
        var time = 0;
        var phases = 0;
        for (int i = 0; i < task.phases.length; i++) {
          var phase = task.phases[i];
          if (this.selectedDay.isAfter(phase.startTime) &&
              this.selectedDay.isBefore(phase.endTime)) {
            time += phase.endTime.difference(this.selectedDay).inMinutes;
            phases += 1;
          } else if (this.selectedDay.isBefore(phase.startTime)) {
            time += phase.endTime.difference(phase.startTime).inMinutes;
            phases += 1;
          }
        }
        if (time != 0) {
          var result = Result(
            title: task.name,
            subtitle: 'Total: $time min. | Phases: $phases',
            time: time,
            bgColor: task.bgColor,
            task: task,
          );
          this.dayTasks.add(result);
          this.dayTasks.sort((a, b) => b.time.compareTo(a.time));
        }
      },
    );
    log(this.selectedDay.toString());
    this.update();
  }
}
