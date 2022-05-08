import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/taskcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/utils/utils.dart';

class TaskPage extends GetView<TaskController> {
  TaskPage({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  Widget build(BuildContext context) {
    Get.put(TaskController());
    controller.task = this.task;
    var textFieldController = TextEditingController(text: controller.task.name);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (context) {
          return SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () => Get.back(),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 28,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () => Get.back(),
                  child: const Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 28,
                  ),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          );
        },
      ),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: GetBuilder<TaskController>(
            builder: (_) {
              log(_.task.name);
              return ListView(
                children: [
                  const Label(text: 'Title'),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 64,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            // initialValue: _.task.name,
                            controller: textFieldController,
                            onChanged: (value) {
                              _.changeName = value;
                            },
                            cursorColor: Colors.white,
                            style: GoogleFonts.openSans(
                                color: Colors.white, fontSize: 16),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.black54,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            textFieldController.clear();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Label(text: 'Color'),
                      Expanded(child: SizedBox()),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 10),
                        width: 128,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _.task.bgColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Select Color',
                            content: ColorPicker(
                              pickerColor: _.task.bgColor,
                              onColorChanged: (value) {
                                _.changeBgColor = value;
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 64,
                    child: Row(
                      children: [
                        const Label(text: 'Description'),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Colors.white,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black54,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Label extends StatelessWidget {
  const Label({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.oswald(fontSize: 24, color: Colors.white),
    );
  }
}
