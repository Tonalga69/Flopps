import 'package:flopps/entities/users/controllers/SignInController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDashboard extends StatelessWidget {
   MainDashboard({Key? key}) : super(key: key);
   final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Center(
        child: OutlinedButton(onPressed: (){AuthController.instance.logOut();}, child: const Text("log out")),
      ),
    );
  }
}
