import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/userController.dart';
import '../model.dart';

class FriendsListItem extends StatefulWidget {
  const FriendsListItem({super.key, required this.friend});

  final UserModel friend;

  @override
  State<FriendsListItem> createState() => _FriendsListItemState();
}

class _FriendsListItemState extends State<FriendsListItem> {
  final userController = UserController.instance;
  final assistantController = Get.put(AssistantController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5),
      width: 90,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              const SizedBox(
                height: 58,
                width: 70,
              ),
              SizedBox(
                height: 48,
                width: 48,
                child: FutureBuilder(
                  future: userController.getProfileUrl(widget.friend.uid),
                  builder: (context, snapshot)
                  {
                          return CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                snapshot.data ?? Strings.defaultProfilePhoto),
                          );
                        }),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: FutureBuilder(
                      future: assistantController.getAssistantPhoto(
                          widget.friend.assistantUid ?? "Initial"),
                      builder: (context, snapshot) {
                          return CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                snapshot.data ?? Strings.defaultProfilePhoto),
                          );
                        }),
                  )),
            ],
          ),
          Text(
            widget.friend.userName ?? "",
            textAlign: TextAlign.center,
            softWrap: true,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(ProjectColors.blackBackground)),
          )
        ],
      ),
    );
  }
}
