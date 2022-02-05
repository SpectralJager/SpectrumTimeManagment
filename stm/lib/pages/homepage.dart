import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/models/categorydata.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AppController>(
        init: AppController(),
        builder: (ctr) {
          ctr.GenerateCategoryDataList();
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .45 - 10,
              width: MediaQuery.of(context).size.width - 10,
              child: SfCircularChart(
                title: ChartTitle(
                  text: "Time spend in last 24 hours (in minutes)",
                  // alignment: ChartAlignment.near
                ),
                legend: Legend(
                  isVisible: false,
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
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
