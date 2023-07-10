import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';

class AssistantItem extends StatefulWidget {
  const AssistantItem({Key? key, this.name, this.photoUrl, required this.onTap})
      : super(key: key);
  final String? name;
  final String? photoUrl;
  final VoidCallback onTap;

  @override
  State<AssistantItem> createState() => _AssistantItemState();
}

class _AssistantItemState extends State<AssistantItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(widget.photoUrl ?? Strings.defaultProfilePhoto),
            radius: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.name ?? "",
            style: const TextStyle(
                color: Colors.white, fontFamily: FontFamily.sourceSansPro),
          )
        ],
      ),
    );
  }
}
