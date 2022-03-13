import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings {
  var homeCardTitleStyle;
  var homeCardSubTitleStyle;

  var appBgColor;
  var appTxtColor;

  var appBarBgColor;
  var appBarTxtColor;

  var drawerBgColor;
  var drawerTxtColor;

  var taskLabelStyle;

  Settings(
      {required this.homeCardTitleStyle,
      required this.homeCardSubTitleStyle,
      required this.appBgColor,
      required this.appTxtColor,
      required this.appBarBgColor,
      required this.appBarTxtColor,
      required this.drawerBgColor,
      required this.drawerTxtColor,
      required this.taskLabelStyle}) {}
}
