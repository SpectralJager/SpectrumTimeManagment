import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:stm/controllers/appcontroller.dart';
import 'package:stm/pages/calendarpage.dart';
import 'package:stm/pages/helppage.dart';
import 'package:stm/pages/homepage.dart';
import 'package:stm/pages/settingspage.dart';
import 'package:stm/utils/appcolors.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(builder: (ctr) {
      return Scaffold(
        floatingActionButton: (ctr.pageIndex < 2)
            ? FloatingActionButton(
                onPressed: () {},
                backgroundColor: ORANGE_WEB,
                child: Icon(Icons.add),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: ctr.pageIndex,
          onItemSelected: (index) {
            print(index);
            ctr.pageIndex = index;
          },
          backgroundColor: RICH_BLACK_FOGRA_29,
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                activeColor: ORANGE_WEB,
                inactiveColor: WHITE),
            BottomNavyBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text("Calendar"),
                activeColor: ORANGE_WEB,
                inactiveColor: WHITE),
            BottomNavyBarItem(
                icon: Icon(Icons.settings_input_component),
                title: Text("Settings"),
                activeColor: ORANGE_WEB,
                inactiveColor: WHITE),
            BottomNavyBarItem(
                icon: Icon(Icons.contact_support),
                title: Text("Help"),
                activeColor: ORANGE_WEB,
                inactiveColor: WHITE),
          ],
        ),
        backgroundColor: OXFORD_BLUE,
        body: PageView(
          controller: ctr.pageController,
          onPageChanged: (index) {
            print(index);
            ctr.pageIndex = index;
          },
          children: [
            HomePage(),
            CalendarPage(),
            SettingsPage(),
            HelpPage(),
          ],
        ),
      );
    });
  }
}
