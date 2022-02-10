import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/utils/appcolors.dart';

class PhasePage extends StatelessWidget {
  const PhasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController ctr = Get.find<AppController>();
    ctr.newPhase = Phase(
        index: ctr.editedTask.phases.length,
        startTime: DateTime.now(),
        endTime: DateTime.now());
    var timer = Timer.periodic(Duration(seconds: 1), (_) => ctr.timeDiff());
    return Scaffold(
      backgroundColor: RICH_BLACK_FOGRA_29,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.stop),
        backgroundColor: Colors.red,
        onPressed: () {
          timer.cancel();
          ctr.newPhase.endTime = DateTime.now();
          ctr.addPhase();
        },
      ),
      body: Center(
        child: Obx(
          () {
            var temp = ctr.td.value.split(':');
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
                        color: PLATINUM,
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: ORANGE_WEB,
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
