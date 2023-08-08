import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({super.key});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(ProjectColors.darkBackground),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              "Friend requests",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: FontFamily.sourceSansPro,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: GetBuilder<UserController>(

                  init: UserController.instance,
                  builder: (controller) {
                if (controller.user.pendingRequests == null ||
                    controller.user.pendingRequests!.isEmpty) {

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: "Here you will receive friend requests!",
                            style: TextStyle(
                                color: Color(ProjectColors.strongBlue),
                                fontFamily: FontFamily.sourceSansPro,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: "\n\n wait for your ",
                                  style: TextStyle(
                                      color:
                                          Color(ProjectColors.blackBackground),
                                      fontFamily: FontFamily.sourceSansPro,
                                      fontWeight: FontWeight.w100)),
                              TextSpan(
                                  text: "Friends´ requests ",
                                  style: TextStyle(
                                      color: Color(ProjectColors.strongBlue),
                                      fontFamily: FontFamily.sourceSansPro,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              TextSpan(
                                  text: "or share your profile with them!",
                                  style: TextStyle(
                                      color:
                                          Color(ProjectColors.blackBackground),
                                      fontFamily: FontFamily.sourceSansPro,

                                      fontWeight: FontWeight.w100))
                            ]),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(ProjectColors.strongBlue)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: const Text("Share profile"),
                      ),
                      Lottie.asset('lib/assets/lotties/waiting.json'),
                      const SizedBox(

                        height: 10,
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  itemCount: controller.user.pendingRequests?.length ?? 0,
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    return RequestItem(user: controller.user.pendingRequests![index]);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
