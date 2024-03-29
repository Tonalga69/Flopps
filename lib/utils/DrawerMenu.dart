import 'package:auth_buttons/auth_buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/entities/events/controllers/eventController.dart';
import 'package:flopps/entities/users/controllers/SignInController.dart';
import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/repositories/authMethod.dart';
import 'package:flopps/screens/Dashboard/MainDashboard/dashboard.dart';
import 'package:flopps/screens/settings/Settings.dart';
import 'package:flopps/screens/social/social_screen.dart';
import 'package:flopps/screens/viewImages/view_images.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Strings.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key? key}) : super(key: key);
  final userController = UserController.instance;
  final authController = Get.put(AuthController());
  final assistantController = AssistantController.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25), topRight: Radius.circular(25))),
      backgroundColor: const Color(ProjectColors.blackBackground),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color(ProjectColors.darkBackground),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(25))),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.only(
                          bottom: 45, left: 45, top: 45, right: 45),
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(4, 4),
                                blurStyle: BlurStyle.normal)
                          ],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(130)),
                          color: Color(ProjectColors.strongBlue)),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                () => ViewImages(
                                    imageUrl:
                                        userController.user.profilePhoto ??
                                            Strings.defaultProfilePhoto,
                                    title: userController.user.userName ??
                                        Strings.profilePhoto),

                                duration: const Duration(milliseconds: 500));
                          },
                          child: Hero(
                            tag: userController.user.profilePhoto ??
                                Strings.defaultProfilePhoto,
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  userController.user.profilePhoto ??
                                      Strings.defaultProfilePhoto),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                          height: 150,
                          padding: const EdgeInsets.only(
                              bottom: 30, left: 30, top: 30, right: 30),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                  () => ViewImages(
                                      imageUrl: assistantController
                                              .assistant?.profilePhoto ??
                                          Strings.defaultProfilePhoto,
                                      title:
                                          assistantController.assistant?.name ??
                                              Strings.assistantPhoto),
                                  duration: const Duration(milliseconds: 500));
                            },
                            child: Hero(
                              tag:
                                  assistantController.assistant?.profilePhoto ??
                                      Strings.defaultProfilePhoto,
                              child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      assistantController
                                              .assistant?.profilePhoto ??
                                          Strings.defaultProfilePhoto)),
                              
                            ),
                          ))),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  color: const Color(ProjectColors.darkBackground),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (userController.user.authMethod == AuthMethod.google)
                        GoogleAuthButton(
                          onPressed: () {},
                          style: const AuthButtonStyle(
                              margin: EdgeInsets.zero,
                              iconType: AuthIconType.secondary,
                              buttonType: AuthButtonType.icon,
                              iconBackground: Colors.transparent,
                              buttonColor: Colors.transparent,
                              width: 18,
                              height: 18,
                              padding: EdgeInsets.zero,
                              separator: 0,
                              elevation: 0,
                              iconSize: 18),
                        )
                      else
                        const Icon(
                          Icons.mail,
                          color: Color(ProjectColors.blue),
                          size: 18,
                        ),
                      Text(
                        userController.user.userName ?? "",
                        style: const TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 14,
                            fontFamily: FontFamily.sourceSansPro,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only( top: 20),
                  height: 1,
                  color: const Color(ProjectColors.grayBackground),
                ),

                ListTile(
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  style: ListTileStyle.drawer,
                  subtitle: const Text("Go to home screen",
                      style: TextStyle(color: Color(0xffffffff))),
                  onTap: () {
                    Get.currentRoute == "/MainDashboard"
                        ? Get.off(() => const MainDashboard(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500))
                        : Get.back(closeOverlays: false, canPop: true);
                    Get.back(closeOverlays: false, canPop: true);
                  },
                  trailing: const Icon(
                    Icons.home_filled,
                    color: Color(ProjectColors.grayBackground),
                  ),
                ),
                Container(
                  height: 1,
                  color: const Color(ProjectColors.grayBackground),
                  width: double.infinity - 100,
                ),
                ListTile(
                  title: const Text(
                    "Social",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  style: ListTileStyle.drawer,
                  subtitle: const Text("Accept requests or connect to others",
                      style: TextStyle(color: Color(0xffffffff))),
                  onTap: () {
                    if (Get.currentRoute == "/MainDashboard") {
                      Get.back();
                      Get.to(() => const SocialScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500));
                    }

                    Get.off(() => const SocialScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500));
                  },
                  trailing: const Icon(
                    Icons.people,
                    color: Color(ProjectColors.grayBackground),
                  ),
                ),
                Container(
                  height: 1,
                  color: const Color(ProjectColors.grayBackground),
                  width: double.infinity - 100,
                ),
                ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  style: ListTileStyle.drawer,
                  subtitle: const Text("Change your user name, photo, etc",
                      style: TextStyle(color: Color(0xffffffff))),
                  onTap: () {
                    if (Get.currentRoute == "/MainDashboard") {
                      Get.back();
                      Get.to(() => const Settings(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500));
                    }

                    Get.off(() => const Settings(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500));
                  },
                  trailing: const Icon(
                    Icons.settings,
                    color: Color(ProjectColors.grayBackground),
                  ),
                ),

                Container(
                  height: 3,
                  width: 25,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                      color: Color(ProjectColors.grayBackground),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                ListTile(
                  title: const Text(
                    "Log out",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  style: ListTileStyle.drawer,
                  onTap: () {
                    authController.logOut(context);
                  },
                  subtitle: const Text("End this session",
                      style: TextStyle(color: Color(0xffffffff))),
                  trailing: const Icon(
                    Icons.logout,
                    color: Color(ProjectColors.grayBackground),
                  ),
                ),

                Column(
                  children: [
                    Container(
                      height: 1,
                      color: const Color(ProjectColors.grayBackground),
                      width: double.infinity - 100,
                    ),
                    ListTile(
                      title: const Text(
                        "About",
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                      style: ListTileStyle.drawer,
                      subtitle: const Text("About Flopps",
                          style: TextStyle(color: Color(0xffffffff))),
                      onTap: () {
                        EventController.instance.openMaps("https://github.com/Tonalga69", context);
                      },
                      trailing: const Icon(
                        Icons.info,
                        color: Color(ProjectColors.grayBackground),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
