import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/models/task.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/phasepage.dart';
import 'package:stm/utils/Categories.dart';
import 'package:stm/utils/appcolors.dart';

class Taskpage extends StatelessWidget {
  const Taskpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ctr = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ORANGE_WEB,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            color: Colors.red,
            child: IconButton(
                onPressed: () {
                  ctr.deleteTask();
                },
                icon: Icon(Icons.delete_forever_outlined),
                iconSize: 30),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(Colors.green.value),
        child: Icon(Icons.assignment_turned_in_outlined),
        onPressed: () {
          ctr.addTask();
        },
      ),
      backgroundColor: RICH_BLACK_FOGRA_29,
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 40),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Name: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ORANGE_WEB),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: PLATINUM),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: OXFORD_BLUE,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: OXFORD_BLUE, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: PLATINUM, width: 1)),
                      ),
                      initialValue: ctr.editedTask.name,
                      onChanged: (value) {
                        ctr.editedTask = ctr.editedTask.copyWith(name: value);
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: PLATINUM,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Category: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ORANGE_WEB),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<Categories>(
                      dropdownColor: OXFORD_BLUE,
                      style: TextStyle(fontSize: 20, color: PLATINUM),
                      iconEnabledColor: ORANGE_WEB,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: OXFORD_BLUE,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      value: ctr.editedTask.category,
                      items: Categories.values
                          .map<DropdownMenuItem<Categories>>((value) =>
                              DropdownMenuItem(
                                child: Text(value.toString().split(".").last),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        ctr.editedTask =
                            ctr.editedTask.copyWith(category: value);
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20,
                thickness: 3,
                color: PLATINUM,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ORANGE_WEB)),
                  onPressed: () {
                    Get.to(() => PhasePage());
                  },
                  child: Icon(Icons.add),
                ),
              ),
              Expanded(
                child: GetBuilder<AppController>(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 70),
                    child: ListView.builder(
                      itemCount: ctr.editedTask.phases.length,
                      itemBuilder: (context, i) {
                        var reversed = ctr.editedTask.phases.reversed.toList();
                        return SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: PLATINUM,
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
                                  Icon(
                                    Icons.timer,
                                  ),
                                ],
                              ),
                              minLeadingWidth: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Taskpage extends StatelessWidget {
//   const Taskpage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     taskController ctrl = Get.put(taskController());
//     appController appCtrl = Get.find<appController>();
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 appCtrl.addTask(ctrl.task);
//                 Get.back();
//               },
//               icon: Icon(Icons.save_alt))
//         ],
//       ),
//       body: GetBuilder<taskController>(
//         builder: (_) => Form(
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: ctrl.task.name,
//                 onChanged: (value) {
//                   ctrl.task.name = value;
//                 },
//               ),
//               DropdownButtonFormField<Categories>(
//                 value: Categories.Other,
//                 items: Categories.values
//                     .map<DropdownMenuItem<Categories>>(
//                         (value) => DropdownMenuItem(
//                               child: Text(value.toString().split(".").last),
//                               value: value,
//                             ))
//                     .toList(),
//                 onChanged: (value) {
//                   ctrl.task.category = value!;
//                 },
//               ),
//               Divider(
//                 height: 5,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Get.to(() => Phasepage());
//                   },
//                   child: Text(
//                     "+",
//                     textScaleFactor: 3,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: ctrl.task.phases.length,
//                   itemBuilder: (context, i) {
//                     return Card(
//                       color: Colors.accents[0],
//                       child: SizedBox(
//                         height: 50,
//                         child: Text(
//                             "${ctrl.task.phases[i].index}\t\t\t${ctrl.task.phases[i].duration}"),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
