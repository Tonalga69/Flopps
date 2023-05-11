

import 'package:flopps/screens/loginScreen/LoginFormLandScape.dart';
import 'package:flopps/screens/loginScreen/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/ProjectColors.dart';
import '../../utils/Strings.dart';
import 'LoginForm.dart';

class LoginLandScape extends StatelessWidget {
  const LoginLandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(ProjectColors.lightBlue),
                  Color(ProjectColors.strongBlue)
                ], begin: Alignment.topLeft, end: Alignment.topRight)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              const Expanded(
                  flex: 35,
                  child: Icon(
                    FontAwesomeIcons.accusoft,
                    size: 48,
                    color: Color(0xffffffff),

                  )),
              Expanded(
                flex: 65,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: formBoxStyle,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //  const Padding(padding: EdgeInsets.all(20)),
                          const Text(
                            Strings.login,
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: "sourceSansPro"
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 40, right: 40),
                              child: const LoginFormLandScape()),

                        ],
                      ),
                    )),
              )
            ],
          ),
        ]));
  }
}