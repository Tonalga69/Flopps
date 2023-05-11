import 'package:flopps/screens/signUp/signUpLandScape.dart';
import 'package:flopps/screens/signUp/signUpPortrait.dart';
import 'package:flutter/material.dart';


class SignUpMain extends StatelessWidget {
  const SignUpMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width<700? const SignUpPortrait(): const SignUpLandScape();
  }
}
