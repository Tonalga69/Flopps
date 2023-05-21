
import 'package:flopps/entities/users/model.dart';
import 'package:flopps/entities/users/repositories/AuthRepository.dart';
import 'package:flopps/entities/users/repositories/UserRepository.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Strings.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();
  UserModel user=AuthRepository.instance.getAuthUserData();

   Future<UserModel> getUserData() async {
    return await UserRepository.instance.getDetailedUserData(uid: user.uid);
  }
  void updateUser({required Map<String, dynamic> map, required BuildContext context}){
      UserRepository.instance.updateUserFields(uid: user.uid, map: map).then((value) {
        if(value!=null) {
          ScaffoldMessenger.of(context).showSnackBar(genericSnackBar(Strings.genericError));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(genericSnackBar(Strings.genericSuccess));
        }
      });

     }
  }
