import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/utils/drawer.dart';

class ResultPage extends StatelessWidget {
  final results;
  const ResultPage({required this.results, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();
    initializeDateFormatting();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppCtr.appBarBgColor,
      ),
      drawer: drawer,
      backgroundColor: AppCtr.appBgColor,
      body: GetBuilder<AppController>(builder: (ctr) {
        return Column(children: [
          Container(
            child: Text(
              DateFormat.yMMMd("ru").format(DateTime.now()),
              style: AppCtr.homeCardTitleStyle,
            ),
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var result = results[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                  color: result.bgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        result.name,
                        style: AppCtr.homeCardTitleStyle,
                      ),
                      subtitle: Text(
                        result.subname,
                        style: AppCtr.homeCardSubTitleStyle,
                      ),
                      textColor: result.txtColor,
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
