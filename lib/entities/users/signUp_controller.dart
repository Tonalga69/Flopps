
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class SignUpController extends GetxController{

  static SignUpController get instance => Get.find();
  final email= TextEditingController();
  final password= TextEditingController();

  //register user
  registerUserWithPassword(String email, String password){

  }

  //login user
  loginUserWithPassword(String email, String password){

  }

  loginWithGoogle(){

  }
}