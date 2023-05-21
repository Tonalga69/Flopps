import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';

import 'Strings.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key? key}) : super(key: key);
  final userController = UserController.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(100)),
                      color: Color(ProjectColors.blue)),
                  child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Image.network(userController.user.profilePhoto ??
                          Strings.defaultProfilePhoto)),
                ),
              ),
              Expanded(child: Image.network(Strings.defaultProfilePhoto)),
            ],
          )
        ],
      ),
    );
  }
}
