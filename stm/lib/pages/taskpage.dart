import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/controllers/taskcontroller.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/models/task.dart';
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
                var task =
                    Task(name: ctrl.name.value, category: ctrl.category.value);
                appCtrl.addTask(task);
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
                initialValue: ctrl.name.value,
                onChanged: (value) {
                  ctrl.name.value = value;
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
                  ctrl.category.value = value!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
