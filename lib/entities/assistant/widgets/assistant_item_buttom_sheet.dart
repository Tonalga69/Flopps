import 'package:flopps/utils/ProjectColors.dart';
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
      child: Container(
        margin: const EdgeInsets.all(10),

        decoration:  BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black26.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(5, 5)
          )],
          borderRadius: const BorderRadius.all(Radius.elliptical(10,10)),
          color: const Color(ProjectColors.blackBackground)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.photoUrl ?? Strings.defaultProfilePhoto),
                radius: 50,
              ),
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
      ),
    );
  }
}
