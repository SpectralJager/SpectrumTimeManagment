import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/controlers/taskcontroller.dart';
import 'package:stm/pages/phasepage.dart';

class TaskPage extends StatelessWidget {
  final task;

  const TaskPage({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();
    var TaskCtr = Get.put(TaskController(task: task));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppCtr.appBarBgColor,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            color: Colors.red,
            child: IconButton(
                onPressed: () {
                  AppCtr.deleteTask(TaskCtr.task);
                },
                icon: Icon(Icons.delete_forever_outlined),
                iconSize: 30),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(Colors.green.value),
        onPressed: () {
          AppCtr.saveTask(TaskCtr.task);
        },
        child: Icon(Icons.save),
      ),
      backgroundColor: AppCtr.appBgColor,
      body: GetBuilder<TaskController>(builder: (ctr) {
        return Column(
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Название: ",
                          style: AppCtr.taskLabelStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: ctr.task.name,
                            onChanged: (value) {
                              ctr.changeName = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Цвет фона: ",
                          style: AppCtr.taskLabelStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: ctr.task.bgColor,
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Выберете цвет",
                              content: ColorPicker(
                                pickerColor: ctr.task.bgColor,
                                onColorChanged: (value) {
                                  ctr.changeBgColor = value;
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Цвет текста: ",
                          style: AppCtr.taskLabelStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: ctr.task.txtColor,
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Выберете цвет",
                              content: ColorPicker(
                                pickerColor: ctr.task.txtColor,
                                onColorChanged: (value) {
                                  ctr.changeTxtColor = value;
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Container(
                      color: AppCtr.appBarBgColor,
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          onPressed: () {
                            Get.to(() => PhasePage());
                          },
                          child: const Text(
                            "Начать новую фазу",
                            style: TextStyle(
                              color: Color(
                                0xffE9D8A6,
                              ),
                              fontSize: 18,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ctr.task.phases.length,
                itemBuilder: (context, i) {
                  var reversed = ctr.task.phases.reversed.toList();
                  return Card(
                    color: null,
                    child: ListTile(
                      title: Text(ctr.phaseTime(reversed[i])),
                      subtitle: Text(ctr.phaseDuration(reversed[i])),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${reversed.length - i} ",
                            textScaleFactor: 2,
                          ),
                          const Icon(
                            Icons.timer,
                          ),
                        ],
                      ),
                      minLeadingWidth: 20,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
