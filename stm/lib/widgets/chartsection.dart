import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/models/categorydata.dart';
import 'package:stm/utils/appcolors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (ctr) {
      // ctr.generateCategoryDataList();
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SfCircularChart(
          title: ChartTitle(
            text: "Time spend in last 24 hours (in minutes)",
            textStyle: GoogleFonts.oswald(
              textStyle: TextStyle(
                color: ORANGE_WEB,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          legend: Legend(
            isVisible: true,
            textStyle: TextStyle(color: PLATINUM),
          ),
          series: [
            PieSeries<CategoryData, String>(
              dataSource: ctr.categoryData,
              xValueMapper: (CategoryData data, _) =>
                  data.category.toString().split(".").last,
              yValueMapper: (CategoryData data, _) => data.duration.inMinutes,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
              radius: '100%',
              explode: true,
            ),
          ],
        ),
      );
    });
  }
}
