import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const STM());
}

class STM extends StatelessWidget {
  const STM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Spectrum Time Managment",
      debugShowCheckedModeBanner: false,
    );
  }
}
