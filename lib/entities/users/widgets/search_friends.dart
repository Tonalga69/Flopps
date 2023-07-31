import 'dart:ui';

import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Strings.dart';
import '../controllers/userController.dart';

class SearchFriends extends StatefulWidget {
  const SearchFriends({super.key});

  @override
  State<SearchFriends> createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            const BoxDecoration(color: Color(ProjectColors.darkBackground)),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Your friends list",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamily.sourceSansPro,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(ProjectColors.white),
              ),
              child: GetBuilder<UserController>(
                  init: UserController.instance,
                  builder: (controller) {
                    if (controller.user.friends == null) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ListView(

                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(ProjectColors.white).withAlpha(200),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Text("You have no friends yet",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: FontFamily.sourceSansPro,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "Search for friends by clicking the search icon on the top right corner",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: FontFamily.sourceSansPro,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                        itemCount: controller.user.friends?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                controller.user.friends?[index].userName ??
                                    "No name"),
                            subtitle: Text(
                                controller.user.friends?[index].email ??
                                    "No email"),
                          );
                        });
                  }),
            ))
          ],
        ));
  }
}
