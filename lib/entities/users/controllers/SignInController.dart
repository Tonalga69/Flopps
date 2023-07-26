import 'package:flopps/entities/users/repositories/AuthRepository.dart';
import 'package:flopps/entities/users/repositories/UserRepository.dart';
import 'package:flopps/entities/users/repositories/authMethod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Strings.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();

  //register user
  registerUserWithPassword(String email, String password) {
    AuthRepository.instance.createUserWithPassword(email, password).then(
        (user) =>
            user != null ? UserRepository.instance.createUser(user) : null);
  }

  //login user
  loginUserWithPassword(String email, String password) {
    AuthRepository.instance.loginWithPassword(email, password);
  }

  logOut(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          alignment: AlignmentDirectional.center,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          title: const  Text("Log out",
              style: TextStyle(
                color: Colors.white,
                fontFamily: FontFamily.sourceSansPro,
              )),
          content: const Text("Are you sure about ending your session?",
              style: TextStyle(
                color: Colors.white,
                fontFamily: FontFamily.sourceSansPro,
              )),
          actions: [
            TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: const Text("Close",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamily.sourceSansPro))),
            TextButton(
                onPressed: ()=>   AuthRepository.instance.logout(),
                child: const Text("Yes",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamily.sourceSansPro)))
          ],
        );
      },
    );

  }

  loginWithGoogle() {
    AuthRepository.instance.loginWithGoogle().then((user) {
      if (user != null) {
        user.authMethod = AuthMethod.google;
        UserRepository.instance.createOrNotUser(user);
      }
    });
  }
}
