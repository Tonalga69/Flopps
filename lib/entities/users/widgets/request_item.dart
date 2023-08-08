import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';
import '../controllers/userController.dart';
import '../model.dart';

class RequestItem extends StatefulWidget {
  const RequestItem({super.key, required this.user});

  final UserModel user;

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  final userController = UserController.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(ProjectColors.strongBlue),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          FutureBuilder(
            future: userController.getProfileUrl(widget.user.uid),
            builder: (context, snapshot) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(snapshot.data ?? ""),
                    ))),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(ProjectColors.darkBackground),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.userName ?? "no name",
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(ProjectColors.white),
                            fontFamily: FontFamily.sourceSansPro,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.user.email,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color(ProjectColors.white),
                            fontFamily: FontFamily.sourceSansPro,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(ProjectColors.blue)),
                        child: TextButton(
                          onPressed: () {
                            userController.acceptFriendRequest(widget.user);
                          },
                          child: const Text(
                            "Accept",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: FontFamily.sourceSansPro,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(ProjectColors.blue)),
                          child: TextButton(
                              onPressed: () {
                                userController
                                    .declineFriendRequest(widget.user);
                              },
                              child: const Text("Decline",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: FontFamily.sourceSansPro)))),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
