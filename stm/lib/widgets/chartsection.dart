import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 12,
                viewportFraction: 1,
                onPageChanged: (i, _) => ctr.slideIndex = i,
              ),
              items: [
                PieChart(
                    interval: "24 hours", categoryData: ctr.categoryData[0]),
                PieChart(interval: "7 days", categoryData: ctr.categoryData[1]),
                PieChart(
                    interval: "30 days", categoryData: ctr.categoryData[2]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ctr.slideIndex == 0 ? RICH_BLACK_FOGRA_29 : PLATINUM,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ctr.slideIndex == 1 ? RICH_BLACK_FOGRA_29 : PLATINUM,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ctr.slideIndex == 2 ? RICH_BLACK_FOGRA_29 : PLATINUM,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

class PieChart extends StatelessWidget {
  const PieChart({
    Key? key,
    required this.interval,
    required this.categoryData,
  }) : super(key: key);

  final String interval;
  final List<CategoryData> categoryData;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(
        text: "Time spend in last ${this.interval} (in minutes)",
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
          dataSource: this.categoryData,
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
    );
  }
}
