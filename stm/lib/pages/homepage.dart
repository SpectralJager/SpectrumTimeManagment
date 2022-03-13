import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';

import 'taskpage.dart';
import 'utils/drawer.dart';
import 'utils/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      backgroundColor: AppCtr.settings.appBgColor,
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
                          style: GoogleFonts.oswald(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Этапов (всего): ${task.phases.length}\nЗатрачено (всего): ${task.phasesTime()} минут.',
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.w300),
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
