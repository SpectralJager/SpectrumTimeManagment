import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var AppCtr = Get.find<AppController>();
    return Scaffold(
      backgroundColor: AppCtr.settings.appBgColor,
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: SpinKitSquareCircle(
            color: AppCtr.settings.appTxtColor,
          ),
        ),
      ),
    );
  }
}
