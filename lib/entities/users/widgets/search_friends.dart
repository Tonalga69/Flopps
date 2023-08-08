

import 'package:flopps/entities/users/widgets/user_result_item.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../screens/social/social_screen.dart';
import '../../../utils/Strings.dart';
import '../controllers/userController.dart';

class SearchFriends extends StatefulWidget {
  const SearchFriends({super.key});

  @override
  State<SearchFriends> createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  final userController = UserController.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
        const BoxDecoration(color: Color(ProjectColors.darkBackground)),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Your friends list",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamily.sourceSansPro,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                  ),
                  onPressed: () {
                    showSearch(
                        useRootNavigator: true,
                        context: context,
                        delegate: SearchBarDelegate());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(ProjectColors.white),
                  ),
                  child: GetBuilder<UserController>(
                    id: "friends",
                      init: UserController.instance,
                      builder: (controller) {
                        if (controller.user.friends == null || controller.user.friends!.isEmpty) {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children:  [
                                const Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(text: "Flopps is better with friends!",
                                      style: TextStyle(
                                          color: Color(ProjectColors.strongBlue),
                                          fontFamily:
                                          FontFamily.sourceSansPro,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),


                                      children: [
                                        TextSpan(
                                            text: "\n\nSearch for ",
                                            style: TextStyle(
                                                color: Color(ProjectColors.blackBackground),
                                                fontFamily:
                                                FontFamily.sourceSansPro,
                                                fontWeight: FontWeight.w100
                                            )),
                                        TextSpan(
                                            text: "Friends ",
                                            style: TextStyle(
                                                color: Color(ProjectColors.strongBlue),
                                                fontFamily:
                                                FontFamily.sourceSansPro,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            )),
                                        TextSpan(
                                            text: "by clicking the search icon 🔍  on the top right corner",
                                            style: TextStyle(
                                              color: Color(ProjectColors.blackBackground),
                                              fontFamily:
                                              FontFamily.sourceSansPro,
                                              fontWeight: FontWeight.w100
                                            ))
                                      ]),),
                                Lottie.asset('lib/assets/lotties/friends.json'),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: controller.user.friends?.length,
                            itemBuilder: (context, index) {
                              return UserResultItem(
                                  user: controller.user.friends![index], alreadyFriends: true,);
                            });
                      }),
                ))
          ],
        ));
  }
}
