import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/taskpage.dart';
import 'package:stm/utils/Categories.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctr = Get.put(appController());
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          textScaleFactor: 3,
        ),
        onPressed: () {
          Get.to(() => Taskpage());
          // var task = Task(
          // name: "Test${Random().nextInt(50)}", category: Categories.Other);
          // ctr.addTask(task);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: GetX<appController>(
          builder: (_) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.width - 40,
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                    ],
                  ),
                ),
                Divider(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ctr.tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.accents[0],
                        child: SizedBox(
                          height: 50,
                          child: Text(
                              "${ctr.tasks[index].getCategory}:${ctr.tasks[index].name}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
