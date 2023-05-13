
import 'package:flopps/entities/users/repositories/UserRepository.dart';
import 'package:flopps/screens/loginScreen/LoginLandScape.dart';
import 'package:flopps/screens/loginScreen/LoginPortrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';




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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));

    return MediaQuery.of(context).size.width < 700
        ? const LoginPortrait()
        : const LoginLandScape();
  }
}
