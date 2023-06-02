import 'package:flopps/entities/users/repositories/AuthRepository.dart';
import 'package:flopps/entities/users/repositories/UserRepository.dart';
import 'package:flopps/entities/users/repositories/authMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  logOut() {
    AuthRepository.instance.logout();
  }

  loginWithGoogle() {
    AuthRepository.instance.loginWithGoogle().then((user) {
    if ( user != null){
      user.authMethod= AuthMethod.google;
      UserRepository.instance.createOrNotUser(user);
    }
    });
  }
}
