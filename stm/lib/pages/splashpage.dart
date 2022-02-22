import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/utils/appcolors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AppController());
    return Scaffold(
      backgroundColor: OXFORD_BLUE,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: SpinKitSquareCircle(
                  color: ORANGE_WEB,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Loading...",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                      color: ORANGE_WEB,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
