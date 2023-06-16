import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';

const enableButtonStyle = ButtonStyle(
    fixedSize: MaterialStatePropertyAll(Size(90, 20)),
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(40)),
    )),
    backgroundColor: MaterialStatePropertyAll(Color(ProjectColors.blue)));

const enableTextStyle = TextStyle(
    color: Color(ProjectColors.white),
    fontFamily: FontFamily.sourceSansPro,
    fontSize: 14,
    fontWeight: FontWeight.w600);
