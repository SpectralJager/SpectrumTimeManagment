import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controllers/taskcontroller.dart';
import 'package:stm/models/phase.dart';
import 'package:stm/pages/phasepage.dart';
import 'package:stm/utils/Categories.dart';
import 'package:stm/utils/appcolors.dart';

class Taskpage extends StatelessWidget {
  const Taskpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ctr = Get.find<TaskController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
        backgroundColor: OXFORD_BLUE,
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.save),
            label: Text("Save"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.delete),
            label: Text("Delete"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ctr.phase = Phase(
            index: ctr.task.phases.length,
            start_time: DateTime.now(),
            end_time: DateTime.now(),
          );
          Get.to(() => PhasePage());
        },
        child: Icon(Icons.add),
        backgroundColor: ORANGE_WEB,
      ),
      backgroundColor: OXFORD_BLUE,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 230,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    initialValue: ctr.task.name,
                    validator: (str) {},
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      ctr.task = ctr.task.copyWith(name: value);
                      print(ctr.task.name);
                    },
                  ),
                  DropdownButtonFormField<Categories>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    value: ctr.task.category,
                    items: [
                      DropdownMenuItem(
                          child: Text(Categories.entertainment.name),
                          value: Categories.entertainment),
                      DropdownMenuItem(
                          child: Text(Categories.sport.name),
                          value: Categories.sport),
                      DropdownMenuItem(
                          child: Text(Categories.work.name),
                          value: Categories.work),
                      DropdownMenuItem(
                          child: Text(Categories.other.name),
                          value: Categories.other),
                    ],
                    onChanged: (value) {
                      ctr.task = ctr.task.copyWith(category: value);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: GetBuilder<TaskController>(builder: (context) {
                return ListView.builder(
                  itemCount: ctr.task.phases.length,
                  itemBuilder: (context, index) {
                    return PhaseCard(
                        index: index, phase: ctr.task.phases[index]);
                  },
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

class PhaseCard extends StatelessWidget {
  const PhaseCard({
    Key? key,
    required this.index,
    required this.phase,
  }) : super(key: key);

  final Phase phase;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 76,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: index.isEven ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: index.isEven ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
                spreadRadius: 2),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ListTile(
              leading: Text(
                "$index",
                style: TextStyle(
                  color: index.isOdd ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
                ),
              ),
              title: Text(
                phase.time,
                style: GoogleFonts.cabin(
                  textStyle:
                      TextStyle(color: WHITE, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(
                phase.duration().inMinutes.toString(),
                style: GoogleFonts.martelSans(
                  textStyle: TextStyle(color: PLATINUM),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 70,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                backgroundColor: index.isOdd ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
              ),
              child: Icon(
                Icons.delete,
                color: index.isEven ? ORANGE_WEB : RICH_BLACK_FOGRA_29,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
