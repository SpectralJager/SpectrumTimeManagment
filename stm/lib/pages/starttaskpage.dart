import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/taskpage.dart';
import 'package:stm/pages/tasktimerpage.dart';
import 'package:stm/pages/utils/createtasksug.dart';
import 'package:stm/pages/utils/startphase.dart';

import 'utils/drawer.dart';
import 'utils/utils.dart';

class StartTaskPage extends StatelessWidget {
  StartTaskPage({Key? key}) : super(key: key);

  Task? task;
  bool isNoneTasks = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (context) {
          return drawerFAB(context: context);
        },
      ),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black87,
        child: GetBuilder<AppController>(
          builder: (ctr) {
            if (ctr.allTasks.length == 0) {
              return CreateTaskSuggestion();
            } else {
              if (this.task == null) {
                this.task = ctr.allTasks[0];
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StartPhase(animation: ctr.animation, task: task!),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          this.task!.name,
                          style: GoogleFonts.oswald(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                            size: 32,
                          ),
                          onSelected: (value) {
                            this.task = value as Task;
                            ctr.update();
                          },
                          itemBuilder: (ctx) => <PopupMenuItem>[
                            for (var item in ctr.allTasks)
                              PopupMenuItem(
                                child: ListTile(
                                    title: Text(
                                      item.name,
                                      style: GoogleFonts.oswald(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: item.bgColor,
                                      ),
                                      child: Center(
                                          child: Text(
                                        item.name[0].toUpperCase(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                        ),
                                      )),
                                    )),
                                value: item,
                              )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
