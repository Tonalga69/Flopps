import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/entities/events/widgets/floatingActionButtonEvents.dart';
import 'package:flopps/screens/events/events.dart';
import 'package:flopps/screens/ia/ia_screen.dart';
import 'package:flopps/screens/sleepTracker/sleepTrackerScreen.dart';
import 'package:flopps/utils/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../entities/events/controllers/eventController.dart';
import '../../../entities/users/controllers/userController.dart';
import '../../../entities/users/model.dart';
import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard>
    with WidgetsBindingObserver {
  final userController = Get.put(UserController());
  final assistantController = Get.put(AssistantController());
  final eventController = Get.put(EventController());
  final appbarTitle = [ Strings.events];

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    assistantController
        .setInitialAssistant()
        .then((value) => assistantController.getSelectedAssistant());
    userController.getUserData().then((value) => null);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          pageIndex == 0 ? FloatingActionButtonEvents() : null,
      appBar: AppBar(
          actions: [
            FutureBuilder(
                future: userController.getUserData(),
                builder: (BuildContext context, AsyncSnapshot<UserModel> user) {
                  return CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        user.data?.profilePhoto ?? Strings.defaultProfilePhoto),
                  );
                }),
            const Padding(padding: EdgeInsets.only(right: 10)),
          ],
          backgroundColor: const Color(ProjectColors.strongBlue),
          systemOverlayStyle: const SystemUiOverlayStyle(),
          title: Text(
            appbarTitle[pageIndex],
            style: const TextStyle(fontFamily: FontFamily.sourceSansPro),
          )),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          Expanded(
            flex: 95,
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              controller: PageController(
                initialPage: 0,
                keepPage: true


              ),
              children: [


                Container(
                    color: const Color(ProjectColors.darkBackground),
                    padding: const EdgeInsets.only(top: 5),
                    child: const EventsScreen()),



              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(5))
        ],
      ),
    );
  }
}
