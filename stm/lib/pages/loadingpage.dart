import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stm/utils/appcolors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RICH_BLACK_FOGRA_29,
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: SpinKitSquareCircle(
            color: ORANGE_WEB,
          ),
        ),
      ),
    );
  }
}
