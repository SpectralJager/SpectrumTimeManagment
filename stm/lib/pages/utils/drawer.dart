import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';

var AppCtr = Get.find<AppController>();
Drawer drawer = Drawer(
  backgroundColor: AppCtr.settings.drawerBgColor,
);
