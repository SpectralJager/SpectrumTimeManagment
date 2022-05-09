import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/tasktimerpage.dart';

import 'utils/drawer.dart';
import 'utils/utils.dart';

class StartTaskPage extends GetView<AppController> {
  StartTaskPage({Key? key}) : super(key: key);

  late Task task;

  @override
  Widget build(BuildContext context) {
    task = controller.allTasks[0];
    return Scaffold(
      drawer: drawer,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            heroTag: null,
            onPressed: () => Scaffold.of(context).openDrawer(),
            child: const Icon(
              Icons.apps,
              color: Colors.white,
              size: 28,
            ),
            backgroundColor: Colors.red,
          );
        },
      ),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black87,
        child: GetBuilder<AppController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.size.width,
                height: Get.size.width,
                padding: EdgeInsets.all(40),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotationTransition(
                      turns: controller.animation,
                      child: SvgPicture.asset(
                        'assets/images/start_btn_bg.svg',
                        width: Get.size.width,
                        color: Colors.green,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => TaskTimerPage(task: task)),
                      child: SvgPicture.asset(
                        'assets/images/start_btn.svg',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task.name,
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
                        task = value as Task;
                        controller.update();
                      },
                      itemBuilder: (ctx) => <PopupMenuItem>[
                        for (var item in _.allTasks)
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
                                    color: Colors.red,
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
        }),
      ),
    );
  }
}
