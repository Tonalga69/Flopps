import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';

import '../../../utils/Strings.dart';
import '../controllers/userController.dart';
import '../model.dart';

class UserResultItem extends StatefulWidget {
  const UserResultItem({super.key, required this.user});

  final UserModel user;

  @override
  State<UserResultItem> createState() => _UserResultItemState();
}

class _UserResultItemState extends State<UserResultItem> {
  final userController = UserController.instance;

  FriendStatus globalStatus = FriendStatus.notFriends;

  @override
  void initState() {
    super.initState();
    final friends = widget.user.friends;
    final requests = widget.user.pendingRequests;

    if (friends != null) {
      for (var element in friends) {
        if (element.uid == userController.user.uid) {
          setState(() {
            globalStatus = FriendStatus.friends;
          });

          break;
        }
      }
    }
    if (requests != null) {
      for (var element in requests) {
        if (element.uid == userController.user.uid) {
          setState(() {
            globalStatus = FriendStatus.pending;
          });

          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Color(ProjectColors.blackBackground),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          height: 48,
                          width: 58,
                        ),
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                widget.user.profilePhoto ??
                                    Strings.defaultProfilePhoto),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    widget.user.profilePhoto ??
                                        Strings.defaultProfilePhoto),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "@${widget.user.userName}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.sourceSansPro,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Text(
                        "common friends",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.sourceSansPro,
                        ),
                      ),
                    ),
                    Row(
                        children: List.generate(
                      4,
                      (index) => Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 24,
                          height: 24,
                          child: index < 3
                              ? CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      widget.user.profilePhoto ??
                                          Strings.defaultProfilePhoto),
                                )
                              : const CircleAvatar(
                                  backgroundColor:
                                      Color(ProjectColors.grayBackground),
                                  child: Text(
                                    "+3",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
                height: 100,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(ProjectColors.grayBackground),
                ),
                child: showBottom(globalStatus)))
      ],
    );
  }

  //////////////////////////////////////////////////////////////

  IconButton showBottom(FriendStatus status) {
    switch (status) {
      case FriendStatus.notFriends:
        return IconButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(ProjectColors.strongBlue))),
            onPressed: () {
              setState(() {

                globalStatus= FriendStatus.pending;
                ScaffoldMessenger.of(context).showSnackBar(friendAddedSnackBar);
              });

              userController.sendFriendRequestTo(
                  widget.user.uid,
                  UserModel(
                    uid: userController.user.uid,
                    email: userController.user.email,
                  ));
            },
            icon: const Icon(Icons.person_add_alt_1, color: Colors.white));

      case FriendStatus.friends:
        return IconButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(ProjectColors.strongBlue))),
            onPressed: () {
              setState(() {
                userController.stopBeingFriends(
                    UserModel(
                      uid: userController.user.uid,
                      email: userController.user.email,
                    ),
                    UserModel(
                      uid: widget.user.uid,
                      email: widget.user.email,
                    ));
                globalStatus = FriendStatus.notFriends;
                ScaffoldMessenger.of(context)
                    .showSnackBar(friendRemovedSnackBar);
              });
            },
            icon: const Icon(Icons.person, color: Colors.white));
      case FriendStatus.pending:
        return IconButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            onPressed: () {
              setState(() {
                userController.cancelFriendRequest(
                    widget.user.uid,
                    UserModel(
                      uid: userController.user.uid,
                      email: userController.user.email,
                    ));
                globalStatus = FriendStatus.notFriends;
                ScaffoldMessenger.of(context)
                    .showSnackBar(cancelFriendRequestSnackBar);
              });
            },
            icon: const Icon(Icons.schedule_send_sharp, color: Colors.white));
    }
  }
}

enum FriendStatus { notFriends, friends, pending }

const friendAddedSnackBar = SnackBar(
    content: Text(
      "Your friend request has been sent!",
      style: TextStyle(
          color: Color(ProjectColors.white),
          fontFamily: FontFamily.sourceSansPro),
    ),
    backgroundColor: Color(ProjectColors.blackBackground),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))));

const friendRemovedSnackBar = SnackBar(
    content: Text(
      "Friend remove",
      style: TextStyle(
          color: Color(ProjectColors.white),
          fontFamily: FontFamily.sourceSansPro),
    ),
    backgroundColor: Color(ProjectColors.blackBackground),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))));

const cancelFriendRequestSnackBar = SnackBar(
    content: Text(
      "Friend request canceled",
      style: TextStyle(
          color: Color(ProjectColors.white),
          fontFamily: FontFamily.sourceSansPro),
    ),
    backgroundColor: Color(ProjectColors.blackBackground),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))));
