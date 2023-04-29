import 'package:flutter/material.dart';
import 'package:flopps/ProjectColors.dart';

var formBoxStyle = const BoxDecoration(
    color: Color(ProjectColors.blackBackground),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
  boxShadow:[ BoxShadow(
    color: Colors.black12,
    offset: Offset(0, -1) ,
    spreadRadius: 5,
    blurRadius: 5


  )]
);


class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _LoginMain();
  }
}

class _LoginMain extends StatefulWidget {
  const _LoginMain({Key? key}) : super(key: key);

  @override
  State<_LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<_LoginMain> {
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack( children: [
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .65,
            padding: const EdgeInsets.all(20),
            decoration: formBoxStyle,

            child: ListView(
              children: [
                Form()
              ],
            )
          )
        ],
      ),
    ]));
  }
}
