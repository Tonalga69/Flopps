import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../entities/users/SignInController.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // transparent status bar
    ));
    return Scaffold(
      drawer: Drawer(
        child: ListView(),

      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.top)),
          OutlinedButton(onPressed: (){SignInController.instance.logOut();}, child: const Text("log out, please")),
        ],
      ),
    );
  }
}
