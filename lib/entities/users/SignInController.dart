
import 'package:flopps/entities/users/repositories/AuthRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class SignInController extends GetxController{

  static SignInController get instance => Get.find();
  final email= TextEditingController();
  final password= TextEditingController();

  //register user
  registerUserWithPassword(String email, String password){
      AuthRepository.instance.createUserWithPassword(email, password);
  }

  //login user
  loginUserWithPassword(String email, String password){
     AuthRepository.instance.loginWithPassword(email, password);
  }

  logOut(){
    AuthRepository.instance.logout();
  }
  loginWithGoogle(){
    AuthRepository.instance.loginWithGoogle();
  }
}