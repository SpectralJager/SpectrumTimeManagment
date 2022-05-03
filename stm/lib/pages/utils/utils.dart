import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

final data = [
  ChartData('Work', 12),
  ChartData('Sport', 15),
  ChartData('Sex', 30),
  ChartData('Studing', 6.4),
];

class bgWidget extends StatelessWidget {
  final String bgImage;
  final Color? overlayColor;
  final Widget child;
  const bgWidget({
    required this.bgImage,
    required this.child,
    this.overlayColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.fill,
          ),
          color: Colors.black,
        ),
        child: Container(
          height: size.height,
          width: size.width,
          color: overlayColor,
          child: child,
        ),
      ),
    );
  }
}
