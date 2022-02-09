import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/loadingpage.dart';

void main() {
  runApp(const STM());
}

class STM extends StatelessWidget {
  const STM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ctr = Get.put(AppController());
    return GetMaterialApp(
      title: "Spectrum Time Managment",
      home: LoadingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
