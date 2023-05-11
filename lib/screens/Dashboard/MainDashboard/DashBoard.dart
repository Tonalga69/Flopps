import 'package:flopps/entities/users/SignInController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDashboard extends StatelessWidget {
   MainDashboard({Key? key}) : super(key: key);
   final controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: OutlinedButton(onPressed: (){SignInController.instance.logOut();}, child: const Text("log out")),
      ),
    );
  }
}
