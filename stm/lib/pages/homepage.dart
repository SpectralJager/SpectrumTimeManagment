import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/models/categorydata.dart';
import 'package:stm/utils/Categories.dart';
import 'package:stm/utils/appcolors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ORANGE_WEB,
        child: Text('+', textScaleFactor: 3),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: RICH_BLACK_FOGRA_29,
      body: GetBuilder<AppController>(
        init: AppController(),
        builder: (ctr) {
          ctr.generateCategoryDataList();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40),
              child: Column(
                children: [
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * .40 - 10,
                    width: MediaQuery.of(context).size.width,
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: "Time spend in last 24 hours (in minutes)",
                        textStyle: TextStyle(
                          color: ORANGE_WEB,
                          fontWeight: FontWeight.bold,
                        ),
                        // alignment: ChartAlignment.near
                      ),
                      legend: Legend(
                        isVisible: true,
                        textStyle: TextStyle(color: PLATINUM),
                        // alignment: ChartAlignment.center
                      ),
                      series: [
                        PieSeries<CategoryData, String>(
                          dataSource: ctr.categoryData,
                          xValueMapper: (CategoryData data, _) =>
                              data.category.toString().split(".").last,
                          yValueMapper: (CategoryData data, _) =>
                              data.duration.inMinutes,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ),
                          radius: '100%',
                          explode: true,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 5,
                    color: PLATINUM,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ctr.tasks.length,
                      itemBuilder: (content, index) {
                        var task = ctr.tasks[index];
                        var icon;
                        switch (task.category) {
                          case Categories.work:
                            icon = Icons.work_outline_outlined;
                            break;
                          case Categories.entertainment:
                            icon = Icons.games_outlined;
                            break;
                          case Categories.sport:
                            icon = Icons.sports_football_outlined;
                            break;
                          case Categories.other:
                            icon = Icons.unarchive_outlined;
                            break;
                        }
                        return SizedBox(
                          height: 80,
                          width: 100,
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ListTile(
                                    leading: Icon(icon),
                                    title: Text(task.name),
                                    subtitle: Text(task.category
                                        .toString()
                                        .split(".")
                                        .last),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_ios_outlined),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
