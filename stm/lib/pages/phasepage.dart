import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/controlers/taskcontroller.dart';
import 'package:stm/models/phase.dart';

class PhasePage extends StatelessWidget {
  const PhasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();
    var TaskCtr = Get.find<TaskController>();
    TaskCtr.newPhase = Phase(
        index: TaskCtr.task.phases.length,
        startTime: DateTime.now(),
        endTime: DateTime.now());
    var timer = Timer.periodic(Duration(seconds: 1), (_) => TaskCtr.timeDiff());
    return Scaffold(
      backgroundColor: AppCtr.settings.appBgColor,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.stop),
        backgroundColor: Colors.red,
        onPressed: () {
          timer.cancel();
          TaskCtr.newPhase.endTime = DateTime.now();
          TaskCtr.addPhase();
          AppCtr.saveTask(TaskCtr.task);
        },
      ),
      body: Center(
        child: Obx(
          () {
            var temp = TaskCtr.td.value.split(':');
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (var item in temp)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffAE2012),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: Color(0xff001219),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
