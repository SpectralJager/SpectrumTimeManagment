import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';

import 'pages/homepage.dart';
import 'pages/loadingpage.dart';

void main() {
  runApp(const STM());
}

class STM extends StatelessWidget {
  const STM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AppController());
    return GetMaterialApp(
      title: "Spectrum Time Managment",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
