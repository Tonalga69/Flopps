
import 'package:flopps/screens/loginScreen/LoginLandScape.dart';
import 'package:flopps/screens/loginScreen/LoginPortrait.dart';
import 'package:flutter/material.dart';




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
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 700
        ? const LoginPortrait()
        : const LoginLandScape();
  }
}
