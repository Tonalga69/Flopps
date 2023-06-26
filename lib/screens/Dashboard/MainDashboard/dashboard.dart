import 'package:flopps/entities/sleepTracker/wigets/sleepTimer.dart';
import 'package:flopps/screens/events/events.dart';
import 'package:flopps/screens/sleepTracker/sleepTrackerScreen.dart';
import 'package:flopps/utils/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../entities/users/controllers/userController.dart';
import '../../../entities/users/model.dart';
import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final userController = Get.put(UserController());
  final appbarTitle = [Strings.events, Strings.sleepTracker];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    userController.getUserData().then((value) => null);
    return Scaffold(
      appBar: AppBar(
          actions: [
            FutureBuilder(
                future: userController.getUserData(),
                builder: (BuildContext context, AsyncSnapshot<UserModel> user) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(
                        user.data?.profilePhoto ?? Strings.defaultProfilePhoto),
                  );
                }),
          ],
          backgroundColor: const Color(ProjectColors.strongBlue),
          systemOverlayStyle: const SystemUiOverlayStyle(),
          title: Text(
            appbarTitle[pageIndex],
            style: const TextStyle(fontFamily: FontFamily.sourceSansPro),
          )),
      drawer: DrawerMenu(),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [
          Container(
              color: const Color(ProjectColors.darkBackground),
              padding: const EdgeInsets.only(top: 5),
              child: const EventsScreen()),
          Container(
              color: const Color(ProjectColors.darkBackground),
              padding: const EdgeInsets.only(top: 5),
              child: const SleepTrackerScreen()),

        ],
      ),
    );
  }
}