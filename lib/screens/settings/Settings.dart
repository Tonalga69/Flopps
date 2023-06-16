import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/widgets/profile.dart';
import 'package:flopps/utils/DrawerMenu.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../entities/assistant/controllers/AssistantController.dart';
import '../../entities/assistant/widgets/settings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final controllerAssistant = Get.put(AssistantController());
  final controllerUser = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    controllerUser.getUserData().then((value) => null);
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(ProjectColors.strongBlue),
      systemOverlayStyle: const SystemUiOverlayStyle(
        //statusBarColor: Colors.transparent,
        //systemStatusBarContrastEnforced: true,

      ),
      title: const Text("Settings", style: TextStyle( fontFamily: FontFamily.sourceSansPro),)),
      drawer: DrawerMenu(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(ProjectColors.darkBackground),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.top)),
              const AssistantSettings(),
              const UserProfile(padding: EdgeInsets.all(10),)
            ],
          ),
        ),
      ),
    );
  }
}
