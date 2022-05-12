import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/utils/utils.dart';

class LoadingPage extends GetView<AppController> {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black12,
        child: SizedBox(
          height: 500,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.size.width,
                height: Get.size.width * .8,
                child: RiveAnimation.asset('assets/animations/loading.riv'),
              ),
              // SpinKitFoldingCube(
              //   color: Colors.white70,
              //   size: 100,
              // ),
              // SizedBox(
              //   height: 50,
              // ),
              Text(
                "Loading",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontSize: 38,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
