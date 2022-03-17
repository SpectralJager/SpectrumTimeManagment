import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/resultpage.dart';
import 'package:stm/pages/resultsforpage.dart';
import 'package:stm/pages/settingspage.dart';

var AppCtr = Get.find<AppController>();
var drawer = Drawer(
  backgroundColor: AppCtr.drawerBgColor,
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        child: Center(
            child: Text(
          'Spectrum Time Managment',
          style: AppCtr.drawerHeaderStyle,
        )),
      ),
      ListTile(
        leading: Icon(Icons.home, color: AppCtr.drawerTxtColor),
        title: Text('Домашняя страница', style: AppCtr.drawerItemStyle),
        onTap: () {
          Get.off(() => HomePage());
        },
      ),
      Divider(
        thickness: 2,
        color: AppCtr.drawerTxtColor,
      ),
      ListTile(
        leading: Icon(Icons.offline_pin, color: AppCtr.drawerTxtColor),
        title: Text('Итоги', style: AppCtr.drawerItemStyle),
        onTap: () {
          var temp = DateTime.now();
          var currentDay = DateTime(temp.year, temp.month, temp.day);
          AppCtr.GenerateResults(currentDay);
        },
      ),
      Divider(
        thickness: 2,
        color: AppCtr.drawerTxtColor,
      ),
      ListTile(
        leading: Icon(
          Icons.offline_share,
          color: AppCtr.drawerTxtColor,
        ),
        title: Text('Итоги за...', style: AppCtr.drawerItemStyle),
        onTap: () {
          Get.off(() => ResultsForPage());
        },
      ),
      Divider(
        thickness: 2,
        color: AppCtr.drawerTxtColor,
      ),
      ListTile(
        leading: Icon(
          Icons.exit_to_app,
          color: AppCtr.drawerTxtColor,
        ),
        title: Text('Выход', style: AppCtr.drawerItemStyle),
        onTap: () {
          exit(0);
        },
      ),
      Divider(
        thickness: 2,
        color: AppCtr.drawerTxtColor,
      ),
    ],
  ),
);
