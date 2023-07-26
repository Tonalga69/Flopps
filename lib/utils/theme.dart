import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';

final theme=ThemeData.dark().copyWith(
    timePickerTheme: const TimePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: Color(ProjectColors.blackBackground),

    ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(ProjectColors.strongBlue),
  ),
  iconTheme: const IconThemeData(
    color: Color(ProjectColors.white)
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
    backgroundColor: Color(ProjectColors.blackBackground)
  )

);