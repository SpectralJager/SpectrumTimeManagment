import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/taskpage.dart';
import 'package:stm/pages/utils/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppCtr.appBarBgColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => TaskPage(
                    task: Task(
                        id: 0,
                        name: '',
                        bgColor: Colors.white,
                        txtColor: Colors.black,
                        phases: [])));
              },
              icon: Icon(Icons.add),
              iconSize: 25),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: drawer,
      backgroundColor: AppCtr.appBgColor,
      body: GetBuilder<AppController>(builder: (ctr) {
        return Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: ctr.tasks.length,
              itemBuilder: (context, index) {
                var task = ctr.tasks[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => TaskPage(task: task));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                    color: task.bgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          task.name,
                          style: AppCtr.homeCardTitleStyle,
                        ),
                        subtitle: Text(
                          'Этапов (всего): ${task.phases.length}\nЗатрачено (всего): ${task.phasesTime()} минут.',
                          style: AppCtr.homeCardSubTitleStyle,
                        ),
                        textColor: task.txtColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      }),
    );
  }
}
