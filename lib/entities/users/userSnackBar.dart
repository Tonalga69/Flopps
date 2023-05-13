import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../utils/ProjectColors.dart';
import '../../utils/Strings.dart';

const errorSnackBar = GetSnackBar(
    backgroundColor: Color(ProjectColors.grayBackground),
    duration: Duration(milliseconds: 3500),
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.all(20),
    isDismissible: true,
    snackPosition: SnackPosition.TOP,
    borderRadius: 10,
    messageText: Text(
      Strings.errorSignInAccount,
      style: TextStyle(
          fontFamily: "sourceSansPro",
          color: Color(0xffffffff),
          fontWeight: FontWeight.w600),
    ),
    icon: Icon(
      FontAwesomeIcons.triangleExclamation,
      color: Color(ProjectColors.blue),
    ));
const errorPasswordSnackBar = GetSnackBar(
    backgroundColor: Color(ProjectColors.grayBackground),
    animationDuration: Duration(milliseconds: 1500),
    snackPosition: SnackPosition.TOP,
    messageText: Text(
      Strings.errorCreatingAccount,
      style: TextStyle(
          fontFamily: "sourceSansPro",
          color: Color(0xffffffff),
          fontWeight: FontWeight.w600),
    ),
    icon: Icon(
      FontAwesomeIcons.check,
      color: Color(ProjectColors.blue),
    ));

const errorInvalidPasswordSnackBar = GetSnackBar(
    backgroundColor: Color(ProjectColors.grayBackground),
    duration: Duration(milliseconds: 3500),
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.all(20),
    isDismissible: true,
    snackPosition: SnackPosition.TOP,
    borderRadius: 10,
    messageText: Text(
      Strings.invalidPassword,
      style: TextStyle(
          fontFamily: "sourceSansPro",
          color: Color(0xffffffff),
          fontWeight: FontWeight.w600),
    ),
    icon: Icon(
      FontAwesomeIcons.triangleExclamation,
      color: Color(ProjectColors.blue),
    ));

const accountCreated = GetSnackBar(
  backgroundColor: Color(ProjectColors.grayBackground),
  duration: Duration(milliseconds: 3500),
  snackStyle: SnackStyle.FLOATING,
  snackPosition: SnackPosition.TOP,
  messageText: Text(
    Strings.accountCreated,
    style: TextStyle(
        fontFamily: "sourceSansPro",
        color: Color(0xffffffff),
        fontWeight: FontWeight.w600),
  ),
  icon: Icon(
    FontAwesomeIcons.check,
    color: Color(ProjectColors.blue),
  ),
);
const errorCreatingAccount = GetSnackBar(
    backgroundColor: Color(ProjectColors.grayBackground),
    animationDuration: Duration(milliseconds: 1500),
    snackPosition: SnackPosition.TOP,
    messageText: Text(
      Strings.errorCreatingAccount,
      style: TextStyle(
          fontFamily: "sourceSansPro",
          color: Color(0xffffffff),
          fontWeight: FontWeight.w600),
    ),
    icon: Icon(
      FontAwesomeIcons.check,
      color: Color(ProjectColors.blue),
    ));
