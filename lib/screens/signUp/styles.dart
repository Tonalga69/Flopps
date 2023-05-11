
import 'package:flutter/material.dart';

import '../../utils/ProjectColors.dart';


var formBoxStyle = const BoxDecoration(
    color: Color(ProjectColors.blackBackground),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
    boxShadow: [
      BoxShadow(
          color: Colors.black12,
          offset: Offset(0, -1),
          spreadRadius: 5,
          blurRadius: 5)
    ]);
