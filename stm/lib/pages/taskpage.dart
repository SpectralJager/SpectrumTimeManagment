import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/controlers/taskcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/utils/colorfield.dart';
import 'package:stm/pages/utils/descriptionfield.dart';
import 'package:stm/pages/utils/phasecard.dart';
import 'package:stm/pages/utils/titlefield.dart';
import 'package:stm/pages/utils/utils.dart';

class TaskPage extends GetView<TaskController> {
  TaskPage(
    Task task, {
    Key? key,
  }) : super(key: key) {
    Get.put(TaskController());
    controller.task = task;
    controller.nameFieldController =
        TextEditingController(text: controller.task.name);
    controller.descriptionFieldController =
        TextEditingController(text: controller.task.description);
  }

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.find<AppController>();
    return GetBuilder<TaskController>(
      init: controller,
      builder: (ctr) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Builder(
            builder: (context) {
              var children = [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () => appController.deleteTask(controller.task),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 28,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () => appController.saveTask(controller.task),
                  child: const Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 28,
                  ),
                  backgroundColor: Colors.green,
                ),
              ];
              return multiFABs(children: children);
            },
          ),
          body: bgWidget(
            bgImage: "assets/images/bg.jpg",
            overlayColor: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  TitleField(
                    nameFieldController: ctr.nameFieldController,
                    onChange: (String value) {
                      ctr.changeName = value;
                    },
                    onTapClear: () {
                      ctr.changeName = '';
                      ctr.nameFieldController.clear();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ColorField(
                    color: ctr.task.bgColor,
                    onColorChanged: (value) {
                      ctr.changeBgColor = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DescriptionField(
                    onTap: () {
                      ctr.changeDescription = '';
                      ctr.descriptionFieldController.clear();
                    },
                    onChange: (value) {
                      ctr.changeDescription = value;
                    },
                    descriptionFieldController: ctr.descriptionFieldController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Label(text: "Phases"),
                  for (var i = ctr.task.phases.length - 1; i >= 0; i--)
                    PhaseCard(
                      phase: ctr.task.phases[i],
                      index: i + 1,
                      title:
                          'Duration: ' + ctr.phaseDuration(ctr.task.phases[i]),
                      subtitle: ctr.phaseTime(ctr.task.phases[i]),
                      onDismissed: () {
                        print(i);
                        ctr.deletePhase(ctr.task.phases[i]);
                      },
                    ),
                  SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
