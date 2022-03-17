import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/utils/drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppCtr.appBarBgColor,
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
                return Card(
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
                        'Затрачено (всего): ${task.phasesTime()} минут.',
                        style: AppCtr.homeCardSubTitleStyle,
                      ),
                      textColor: task.txtColor,
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
