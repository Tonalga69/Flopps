import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';

final theme = ThemeData.dark().copyWith(
  timePickerTheme: const TimePickerThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    backgroundColor: Color(ProjectColors.blackBackground),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(ProjectColors.strongBlue),
  ),
  iconTheme: const IconThemeData(color: Color(ProjectColors.white)),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: Color(ProjectColors.blackBackground)),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(ProjectColors.white),
    indicatorColor: Color(ProjectColors.strongBlue),
    shadowColor: Color(ProjectColors.strongBlue),
    surfaceTintColor: Color(ProjectColors.strongBlue),
    labelTextStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
        color: Color(ProjectColors.white),
        fontFamily: FontFamily.sourceSansPro)),
    elevation: 0,
  ),
);
