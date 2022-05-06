import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/loadingpage.dart';
import 'package:stm/pages/taskspage.dart';

var AppCtr = Get.find<AppController>();
var drawer = Drawer(
  backgroundColor: Colors.black54,
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        child: Center(
          child: Text(
            'Spectrum Time Managment',
            style: GoogleFonts.oswald(
              color: Colors.redAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Divider(
        thickness: 2,
        color: Colors.white,
      ),
      ListTile(
        leading: Icon(Icons.home, color: Colors.red),
        title: Text(
          'Home page',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          // create toHomePage()
          Get.off(() => HomePage());
        },
      ),
      ListTile(
        leading: Icon(Icons.list_alt, color: Colors.red),
        title: Text(
          'Tasks',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          Get.off(() => TasksPage());
        },
      ),
      ListTile(
        leading: Icon(Icons.play_arrow, color: Colors.red),
        title: Text(
          'Start task',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {},
      ),
    ],
  ),
);
