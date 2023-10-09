import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';

import '../../../utils/Strings.dart';
import '../../assistant/controllers/AssistantController.dart';
import '../controllers/userController.dart';
import '../model.dart';

class UserResultItem extends StatefulWidget {
  const UserResultItem(
      {super.key,
      required this.user,
      this.alreadyFriends = false,
      this.canChangeFriendStatus = true});

  final UserModel user;
  final bool alreadyFriends;
  final bool canChangeFriendStatus;

  @override
  State<UserResultItem> createState() => _UserResultItemState();
}

class _UserResultItemState extends State<UserResultItem> {
  final userController = UserController.instance;
  final assistantController = AssistantController.instance;
  List<UserModel> commonFriends = [];

  FriendStatus globalStatus = FriendStatus.notFriends;

  @override
  void initState() {
    super.initState();
    final friends = widget.user.friends;
    final requests = widget.user.pendingRequests;

    if (widget.alreadyFriends) {
      globalStatus = FriendStatus.friends;

      return;
    }
    if (friends != null && friends.isNotEmpty) {
      for (var element in friends) {
        if (element.uid == userController.user.uid) {
          globalStatus = FriendStatus.friends;

          break;
        }
      }

      for (var element in friends) {
        for (var element2 in userController.user.friends!) {
          if (element.uid == element2.uid) {
            commonFriends.add(element);
          }
        }
      }
    }
    if (requests != null) {
      for (var element in requests) {
        if (element.uid == userController.user.uid) {
          globalStatus = FriendStatus.pending;

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
            margin: EdgeInsets.only(left: widget.alreadyFriends ? 10 : 0),
            height: widget.alreadyFriends ? 60 : 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: widget.alreadyFriends
                      ? const Radius.circular(10)
                      : const Radius.circular(25),
                  bottomLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomRight: const Radius.circular(10)),
              color: const Color(ProjectColors.blackBackground),
            ),
            child: Column(
              mainAxisAlignment: widget.alreadyFriends
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.alreadyFriends
                        ? const SizedBox(
                            width: 10,
                          )
                        : const SizedBox(),
                    Stack(
                      children: [
                        const SizedBox(
                          height: 48,
                          width: 58,
                        ),
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: FutureBuilder(
                            future:
                                userController.getProfileUrl(widget.user.uid),
                            builder: (context, snapshot) => CircleAvatar(
                              backgroundImage: NetworkImage(
                                  widget.user.profilePhoto ??
                                      snapshot.data ??
                                      Strings.defaultProfilePhoto),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: FutureBuilder(
                                  future: assistantController.getAssistantPhoto(
                                      widget.user.assistantUid ?? "Initial"),
                                  builder: (context, snapshot) => CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      snapshot.data ??
                                          Strings.defaultProfilePhoto,
                                    ),
                                  ),
                                )))
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
                widget.alreadyFriends
                    ? Column()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          commonFriends.isEmpty
                              ? Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: const Text(
                                        "No common friends",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontFamily.sourceSansPro,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Text(
                                    "Common friends",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: FontFamily.sourceSansPro,
                                    ),
                                  ),
                                ),
                          Row(
                            children: List.generate(
                              commonFriends.length,
                              (index) => Container(
                                margin: const EdgeInsets.only(right: 5),
                                width: 24,
                                height: 24,
                                child: index < 3
                                    ? FutureBuilder(
                                        future: userController.getProfileUrl(
                                            commonFriends[index].uid),
                                        builder: (context, snapshot) =>
                                            CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  snapshot.data ??
                                                      Strings
                                                          .defaultProfilePhoto),
                                        ),
                                      )
                                    : index == 3
                                        ? CircleAvatar(
                                            backgroundColor: const Color(
                                                ProjectColors.grayBackground),
                                            child: Text(
                                              "+${commonFriends.length - 3}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : const SizedBox(),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
        widget.canChangeFriendStatus
            ? Expanded(
                flex: 1,
                child: Container(
                    height: widget.alreadyFriends ? 60 : 100,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(ProjectColors.grayBackground),
                    ),
                    child: showBottom(globalStatus)))
            : const SizedBox()
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
                globalStatus = FriendStatus.pending;
                ScaffoldMessenger.of(context).showSnackBar(friendAddedSnackBar);
              });

              userController.sendFriendRequestTo(
                  widget.user.uid,
                  UserModel(
                    uid: userController.user.uid,
                    email: userController.user.email,
                    userName: userController.user.userName,
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
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Remove friend"),
                    content: const Text(
                        "Are you sure you want to remove this friend?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              userController.stopBeingFriends(
                                  UserModel(
                                    uid: userController.user.uid,
                                    email: userController.user.email,
                                    userName: userController.user.userName,
                                  ),
                                  UserModel(
                                    uid: widget.user.uid,
                                    email: widget.user.email,
                                    userName: widget.user.userName,
                                  ));
                              globalStatus = FriendStatus.notFriends;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(friendRemovedSnackBar);
                            });
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Remove")),
                    ],
                  );
                },
              );
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
