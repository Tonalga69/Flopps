import 'package:flopps/screens/signUp/SignUpForm.dart';
import 'package:flopps/screens/signUp/styles.dart';
import 'package:flutter/material.dart';

import '../../utils/ProjectColors.dart';
import '../../utils/Strings.dart';

class SignUpPortrait extends StatelessWidget {
  const SignUpPortrait({Key? key}) : super(key: key);

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
            children: [
               Expanded(
                  flex: 35,
                  child: Container(
                    alignment: Alignment.center,
                    child:  const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage:
                        AssetImage("lib/assets/images/logo.png",),
                      ),
                    ),
                  ),),
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
                            Strings.signUp,
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: "sourceSansPro"
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: const SignUpForm()),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ]));
  }
}
