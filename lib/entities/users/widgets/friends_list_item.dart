import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';

class FriendsListItem extends StatefulWidget {
  const FriendsListItem({super.key});

  @override
  State<FriendsListItem> createState() => _FriendsListItemState();
}

class _FriendsListItemState extends State<FriendsListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: 90,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: const [
              SizedBox(
                height: 58,
                width: 70,
              ),
              SizedBox(
                height: 48,
                width: 48,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(Strings.defaultProfilePhoto),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(Strings.defaultProfilePhoto),
                    ),
                  )),
            ],
          ),
          const Text(
            "El ximeno popo",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(ProjectColors.blackBackground)),
          )
        ],
      ),
    );
  }
}
