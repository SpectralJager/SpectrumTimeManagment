import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:stm/pages/utils/utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.redAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.size.width,
              height: Get.size.width,
              child:
                  RiveAnimation.asset('assets/animations/splash_loading.riv'),
            ),
            Text(
              "Spectrum Time Managment",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                color: Colors.black,
                fontSize: 38,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
