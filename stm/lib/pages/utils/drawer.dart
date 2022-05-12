import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/starttaskpage.dart';
import 'package:stm/pages/taskspage.dart';

var AppCtr = Get.find<AppController>();
var drawer = Drawer(
  backgroundColor: Colors.black87,
  child: ListView(
    padding: EdgeInsets.only(top: 40),
    children: [
      DrawerHeader(
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset('assets/images/drawer_img.svg'),
            ),
            Text(
              'Spectrum Time Managment',
              style: GoogleFonts.oswald(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Divider(
        thickness: 1,
        color: Colors.white70,
      ),
      ListTile(
        leading: Icon(
          Icons.home,
          color: Colors.red,
          size: 32,
        ),
        title: Text(
          'Home page',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          AppCtr.fetchNDayTasks(AppCtr.selectedDay);
          Get.off(
            () => HomePage(),
            duration: Duration(seconds: 1),
            transition: Transition.rightToLeft,
          );
        },
      ),
      ListTile(
        leading: Icon(
          Icons.list_alt,
          color: Colors.red,
          size: 32,
        ),
        title: Text(
          'Tasks',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          Get.off(
            () => TasksPage(),
            duration: Duration(seconds: 1),
            transition: Transition.rightToLeft,
            curve: Curves.easeIn,
          );
        },
      ),
      ListTile(
        leading: Icon(
          Icons.play_arrow,
          color: Colors.red,
          size: 32,
        ),
        title: Text(
          'Start task',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          Get.to(
            () => StartTaskPage(),
            duration: Duration(seconds: 1),
            transition: Transition.rightToLeft,
          );
        },
      ),
    ],
  ),
);
