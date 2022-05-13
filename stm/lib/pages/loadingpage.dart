import 'package:flutter/material.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.size.width,
              height: Get.size.width * .8,
              child: RiveAnimation.asset('assets/animations/loading.riv'),
            ),
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
    );
  }
}
