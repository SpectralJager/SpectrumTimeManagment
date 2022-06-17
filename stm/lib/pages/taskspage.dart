import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/taskpage.dart';
import 'package:stm/pages/utils/taskcard.dart';
import 'package:stm/pages/utils/tasksheader.dart';

import 'utils/drawer.dart';
import 'utils/utils.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (ctr) {
        return Scaffold(
          drawer: drawer,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Builder(builder: (context) {
            return multiFABs(
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () => Get.to(
                    () => TaskPage(
                      Task(
                          id: 0,
                          name: '',
                          description: '',
                          phases: [],
                          bgColor: Colors.red),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                  backgroundColor: Colors.green,
                ),
                drawerFAB(
                  context: context,
                ),
              ],
            );
          }),
          body: bgWidget(
            bgImage: "assets/images/bg.jpg",
            overlayColor: Colors.black54,
            child: Column(
              children: [
                TasksHeader(),
                ctr.allTasks.length == 0
                    ? NothingWidget()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: ctr.allTasks.length,
                          itemBuilder: (ctx, index) {
                            var task = ctr.allTasks[index];
                            var subtitle = 'Total: ' +
                                task.totalDuration.toString() +
                                ' min. | Phases: ' +
                                task.phases.length.toString();
                            return TaskCard(
                                task: task,
                                title: task.name,
                                subtitle: subtitle);
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
