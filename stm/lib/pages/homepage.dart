import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/pages/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        backgroundColor: Colors.red,
      ),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black26,
        child: Column(
          children: [
            Calendar(),
            Divider(
              height: 2,
              thickness: 2,
              color: Colors.white,
            ),
            Chart(data: data),
            Expanded(
              child: GridCards(data: data),
            ),
          ],
        ),
      ),
    );
  }
}

final data = [
  _ChartData('Work', 12),
  _ChartData('Sport', 15),
  _ChartData('Sex', 30),
  _ChartData('Studing', 6.4),
];

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
