import 'package:auth_buttons/auth_buttons.dart';
import 'package:flopps/entities/users/controllers/SignInController.dart';
import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/repositories/authMethod.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Strings.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key? key}) : super(key: key);
  final userController = UserController.instance;
  final authController = Get.put(AuthController());

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
                borderRadius: BorderRadius.only(topRight: Radius.circular(25))
              ),
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
                          borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(130)),
                          color: Color(ProjectColors.strongBlue)),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            userController.user.profilePhoto ??
                                Strings.defaultProfilePhoto),
                        radius: 60,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                          height: 150,
                          padding: const EdgeInsets.only(
                              bottom: 30, left: 30, top: 30, right: 30),
                          child: const CircleAvatar(
                              backgroundImage:
                                  NetworkImage(Strings.defaultProfilePhoto)))),
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
                        ) else
                        const Icon(Icons.mail,
                            color: Color(ProjectColors.blue), size: 18,),
                      Text(userController.user.userName?? "", style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 14,
                          fontFamily: FontFamily.sourceSansPro,

                          fontWeight: FontWeight.w600
                      ),),
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
                    "Settings",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  style: ListTileStyle.drawer,
                  subtitle: const Text("Change your user name, photo, etc",
                      style: TextStyle(color: Color(0xffffffff))),
                  onTap: () {},
                  trailing: const Icon(
                    Icons.settings,
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
                    "Log out",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  style: ListTileStyle.drawer,
                  onTap: () {
                    authController.logOut();
                  },
                  subtitle: const Text("End this session",
                      style: TextStyle(color: Color(0xffffffff))),
                  trailing: const Icon(
                    Icons.logout,
                    color: Color(ProjectColors.grayBackground),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
