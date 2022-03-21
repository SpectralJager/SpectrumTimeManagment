import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stm/models/result.dart';
import 'package:stm/pages/resultpage.dart';

import '../models/task.dart';
import '../pages/homepage.dart';
import '../pages/loadingpage.dart';

class AppController extends GetxController {
  List<Task> tasks = [];
  List<Result> results = [];

  late Database _db;
  late StoreRef _taskStore;
  late StoreRef _appStore;

  //settings--
  //  fonts--
  var homeCardTitleStyle =
      GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.bold);
  var homeCardSubTitleStyle =
      GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w300);
  var taskLabelStyle =
      GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.bold);
  var phaseStyle = GoogleFonts.openSans(
    fontSize: 30,
    color: Color(0xffE9D8A6),
    fontWeight: FontWeight.bold,
  );
  var drawerHeaderStyle = GoogleFonts.oswald(
      fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xffE9D8A6));
  var drawerItemStyle = GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xffE9D8A6));
  //  --fonts
  //  colors--
  var appBgColor = Color(0xffE9D8A6);
  var appTxtColor = Color(0xff001219);
  var appBarBgColor = Color(0xffEE9B00);
  var appBarTxtColor = Color(0xff001219);
  var drawerBgColor = Color(0xffBB3E03);
  var drawerTxtColor = Color(0xffE9D8A6);
  //  --colors
  //--settings

  @override
  void onInit() async {
    super.onInit();
    if (await Permission.storage.request().isDenied) {
      exit(0);
    }
    await this.initDB();
    await this.isFirstTime();
    await this.fetchTasks();
    // print(this.tasks);
    Get.off(() => HomePage());
  }

  Future initDB() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "stm.db");
    this._db = await databaseFactoryIo.openDatabase(databasePath);
    log("database open/created succesfully!");
    this._appStore = StoreRef<String, dynamic>.main();
    log("app store open/created succesfully!");
    this._taskStore = intMapStoreFactory.store("tasks_store");
    log("task store open/created succesfully!");
    return Future.delayed(Duration(seconds: 1));
  }

  Future isFirstTime() async {
    // await this._appStore.record('isFirst').put(this._db, true);
    var isFirst = await this._appStore.record('isFirst').get(this._db);
    if (isFirst != false) {
      List<Task> tempTasks = [
        Task(
            id: 0,
            name: 'Прогулка',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Работа',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Магазин',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Сон',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Отдых',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Интернет',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Сериалы',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Чтение',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
        Task(
            id: 0,
            name: 'Прием пищи',
            phases: [],
            bgColor: Color(Colors.white.hashCode),
            txtColor: Color(Colors.black.hashCode)),
      ];
      tempTasks.forEach(
        (element) async {
          await this._taskStore.add(this._db, element.toMap());
        },
      );
      await this._appStore.record('isFirst').put(this._db, false);
    }
    return Future.delayed(Duration(seconds: 1));
  }

  Future fetchTasks() async {
    final snapshot = await this._taskStore.find(this._db);
    this.tasks = snapshot
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

  void GenerateResults(DateTime currentDay) {
    Get.off(() => LoadingPage());
    this.results = [];
    this.tasks.forEach((task) {
      var time = 0;
      for (int i = 0; i < task.phases.length; i++) {
        var phase = task.phases[i];
        if (currentDay.isAfter(phase.startTime) &&
            currentDay.isBefore(phase.endTime)) {
          time += phase.endTime.difference(currentDay).inMinutes;
        } else if (currentDay.isBefore(phase.startTime)) {
          time += phase.endTime.difference(phase.startTime).inMinutes;
        }
      }
      if (time != 0) {
        var result = Result(
            name: task.name,
            subname: 'Затрачено $time минут',
            time: time,
            bgColor: task.bgColor,
            txtColor: task.txtColor);
        this.results.add(result);
        this.results.sort((a, b) => b.time.compareTo(a.time));
      }
    });
    Get.off(() => ResultPage(results: this.results, date: currentDay));
  }
}
