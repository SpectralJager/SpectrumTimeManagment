import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/controllers/taskcontroller.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/phasepage.dart';
import 'package:stm/utils/Categories.dart';

class Taskpage extends StatelessWidget {
  const Taskpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    taskController ctrl = Get.put(taskController());
    appController appCtrl = Get.find<appController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                appCtrl.addTask(ctrl.task);
                Get.back();
              },
              icon: Icon(Icons.save_alt))
        ],
      ),
      body: GetX<taskController>(
        builder: (_) => Form(
          child: Column(
            children: [
              TextFormField(
                initialValue: ctrl.task.name,
                onChanged: (value) {
                  ctrl.task.name = value;
                },
              ),
              DropdownButtonFormField<Categories>(
                value: Categories.Other,
                items: Categories.values
                    .map<DropdownMenuItem<Categories>>(
                        (value) => DropdownMenuItem(
                              child: Text(value.toString().split(".").last),
                              value: value,
                            ))
                    .toList(),
                onChanged: (value) {
                  ctrl.task.category = value!;
                },
              ),
              Divider(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => Phasepage());
                  },
                  child: Text(
                    "+",
                    textScaleFactor: 3,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ctrl.phases.value.length,
                  itemBuilder: (context, i) {
                    return Card(
                      color: Colors.accents[0],
                      child: SizedBox(
                        height: 50,
                        child: Text(
                            "${ctrl.phases.value[i].index}\t\t\t${ctrl.phases.value[i].duration}"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
