import 'package:flopps/utils/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../entities/assistant/controllers/AssistantController.dart';
import '../../../entities/users/controllers/userController.dart';
import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final userController= Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.getUserData().then((value) => null);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(ProjectColors.strongBlue),
          systemOverlayStyle: const SystemUiOverlayStyle(
              //statusBarColor: Colors.transparent,
              //systemStatusBarContrastEnforced: true,

              ),
          title: const Text(
            "Dashboard",
            style: TextStyle(fontFamily: FontFamily.sourceSansPro),
          )),
      drawer: DrawerMenu(),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(ProjectColors.darkBackground),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.top)),
              ],
            ),
          ),
        )
      ),
    );
  }
}
