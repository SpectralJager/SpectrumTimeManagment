import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:stm/models/categorydata.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';
import 'package:stm/utils/Categories.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppController extends GetxController {
  var tasks = [
    Task(name: "Teaching", category: Categories.work, phases: [
      Phase(
          index: 1,
          startTime: DateTime(2022, 2, 4, 22, 30),
          endTime: DateTime(2022, 2, 5, 2)),
      Phase(
          index: 2,
          startTime: DateTime(2022, 2, 5, 10, 30),
          endTime: DateTime(2022, 2, 5, 12, 10)),
    ]),
    Task(name: "Coding", category: Categories.work, phases: [
      Phase(
          index: 1,
          startTime: DateTime(2022, 2, 5, 12),
          endTime: DateTime.now())
    ]),
    Task(name: "Playing", category: Categories.entertainment, phases: [
      Phase(
          index: 1,
          startTime: DateTime(2022, 2, 5, 10),
          endTime: DateTime(2022, 2, 5, 11, 30))
    ]),
    Task(name: "Running", category: Categories.sport, phases: [
      Phase(
          index: 1,
          startTime: DateTime(2022, 2, 4, 16, 10),
          endTime: DateTime(2022, 2, 4, 18))
    ]),
  ];

  List<CategoryData> categoryData = [];

  void GenerateCategoryDataList() {
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
    this.update();
  }
}
