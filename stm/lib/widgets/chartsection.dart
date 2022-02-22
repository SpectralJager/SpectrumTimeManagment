import 'package:carousel_slider/carousel_slider.dart';
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
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          bottom: 30,
          top: 30,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
            color: ORANGE_WEB,
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 12,
            viewportFraction: 1,
          ),
          items: [
            SfCircularChart(
              title: ChartTitle(
                text: "Time spend in last 24 hours (in minutes)",
                textStyle: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    color: RICH_BLACK_FOGRA_29,
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
          ],
        ),
      );
    });
  }
}
