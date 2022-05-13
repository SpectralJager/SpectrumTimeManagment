import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/models/result.dart';
import 'package:stm/pages/utils/taskcard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeBody extends StatelessWidget {
  HomeBody({
    Key? key,
    required this.results,
  }) : super(key: key);

  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          HomeChart(
            results: this.results,
          ),
          for (var result in this.results)
            TaskCard(
              task: result.task,
              title: result.title,
              subtitle: result.subtitle,
            ),
        ],
      ),
    );
  }
}

class HomeChart extends StatelessWidget {
  HomeChart({
    Key? key,
    required this.results,
  }) : super(key: key);

  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SfCartesianChart(
        title: ChartTitle(
          text: "Time spend (in minutes)",
          textStyle: GoogleFonts.oswald(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        primaryYAxis: NumericAxis(minimum: 0, interval: 10),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: [
          BarSeries<Result, String>(
            dataSource: results,
            xValueMapper: (Result data, _) => data.title,
            yValueMapper: (Result data, _) => data.time,
            name: 'Minutes',
            pointColorMapper: (Result data, _) => data.bgColor,
            sortFieldValueMapper: (data, _) => data.time,
            sortingOrder: SortingOrder.ascending,
          ),
        ],
      ),
    );
  }
}
