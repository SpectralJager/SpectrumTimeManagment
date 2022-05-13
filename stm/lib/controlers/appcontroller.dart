import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/result.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/loadingpage.dart';

class AppController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  List<Task> allTasks = [];
  List<Result> dayTasks = [];

  late DateTime selectedDay;

  late Database _db;
  late StoreRef _taskStore;

  @override
  void onInit() async {
    super.onInit();
    if (await Permission.storage.request().isDenied) {
      exit(0);
    }
    precacheImage(AssetImage('assets/images/bg.jpg'), Get.context!);
    this.initAnimation();
    await this.initDB();
    await this.fetchTasks();
    await this.fetchSelectedDayTasks(DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
    // await Future.delayed(Duration(seconds: 3));
    Get.off(
      () => HomePage(),
      duration: Duration(seconds: 3),
      transition: Transition.fadeIn,
    );
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
    if (task.name == '') {
      Get.snackbar(
        'Error: Empty task title',
        'Enter Task title before saving!!!',
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
      return null;
    }
    Get.off(() => LoadingPage());
    print(task.bgColor.value);
    if (task.id == 0) {
      await this._taskStore.add(this._db, task.toMap());
    } else {
      await this._taskStore.record(task.id).update(this._db, task.toMap());
    }
    await this.fetchTasks();
    await this.fetchSelectedDayTasks(this.selectedDay);
    Get.back();
    this.update();
  }

  Future deleteTask(Task task) async {
    if (task.id != 0) {
      Get.off(() => LoadingPage());
      await this._taskStore.record(task.id).delete(this._db);
      await this.fetchTasks();
      await this.fetchSelectedDayTasks(this.selectedDay);
    }
    Get.back();
    this.update();
  }

  Future fetchSelectedDayTasks(DateTime date) async {
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
          } else if (this.selectedDay.isBefore(phase.startTime) &&
              this.selectedDay.add(Duration(days: 1)).isAfter(phase.endTime)) {
            time += phase.endTime.difference(phase.startTime).inMinutes;
            phases += 1;
          } else if (this.selectedDay.isBefore(phase.startTime) &&
              this.selectedDay.add(Duration(days: 1)).isBefore(phase.endTime) &&
              this
                  .selectedDay
                  .add(Duration(days: 1))
                  .isAfter(phase.startTime)) {
            time += this
                .selectedDay
                .add(Duration(days: 1))
                .difference(phase.startTime)
                .inMinutes;
            phases += 1;
          }
        }
        if (time != 0) {
          var result = Result(
            title: task.name,
            subtitle: 'Spend: $time min. | Phases: $phases',
            time: time,
            bgColor: task.bgColor,
            task: task,
          );
          this.dayTasks.add(result);
          this.dayTasks.sort((a, b) => b.time.compareTo(a.time));
        }
      },
    );
    this.update();
    return Future.delayed(Duration(seconds: 1));
  }
}
