import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/screens/viewImages/view_images.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({super.key, required this.isMe});

  final bool isMe;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool isVisible = false;
  AssistantController assistantController = AssistantController.instance;
  UserController userController = UserController.instance;
  int value = 0;

  @override
  void initState() {
    super.initState();
    value = Random().nextInt(2);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isVisible = true;
      });
    });
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.2,
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment:
            widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          !widget.isMe? Padding(padding: const EdgeInsets.all(5.0)): const SizedBox(),
          Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(ProjectColors.grayBackground),
                backgroundImage: CachedNetworkImageProvider(
                  widget.isMe
                      ? userController.user.profilePhoto ??
                          Strings.defaultProfilePhoto
                      : assistantController.assistant?.profilePhoto ??
                          Strings.defaultProfilePhoto2,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isMe
                        ? const Color(ProjectColors.strongBlue)
                        : const Color(ProjectColors.darkBackground),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(4, 4),
                      ),
                    ],
                    border:  value.isEven? Border.all(
                      color: const Color(ProjectColors.white),
                      width: 1,
                    ): null,
                  ),
                  child: Padding(
                    padding: value.isEven? const EdgeInsets.all(5.0): const EdgeInsets.all(0.0),
                    child: value.isEven?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.isMe
                            ? const SizedBox()
                            : IconButton(
                                icon: const Icon(
                                    Icons.copy,
                                    color: Color(ProjectColors.white)),
                                constraints: const BoxConstraints(
                                  maxWidth: 24,
                                  maxHeight: 24,
                                ),
                                iconSize: 18,
                                onPressed: () {
                                  Clipboard.setData(const ClipboardData(
                                      text: Strings.dummyText));
                                  const snackBar = SnackBar(
                                    content: Text(
                                      'Copied to clipboard',
                                      style: TextStyle(
                                          color: Color(ProjectColors.white)),
                                    ),
                                    backgroundColor:
                                        Color(ProjectColors.darkBackground),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ),
                        const SizedBox(height: 5),

                            const Text(
                                Strings.dummyText,
                                style: TextStyle(
                                  color: Color(ProjectColors.white),
                                ),
                              )

                      ],
                    ): Stack(
                      children: [
                        InkWell(

                            onTap: () {
                              Get.to(const ViewImages(
                                  imageUrl: Strings.foquitaUrl, title: ""));
                            },
                            child: Hero(
                                tag: Strings.foquitaUrl,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                      imageUrl: Strings.foquitaUrl),
                                ))),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                          icon: const Icon(
                              Icons.download,
                              color: Color(ProjectColors.white)),
                          onPressed: () {
                            assistantController.downloadPicture(Strings.foquitaUrl);
                          },
                        ),

                        )
                      ],
                    )
                  )),
            ],
          ),
          widget.isMe? Padding(padding: const EdgeInsets.all(5.0)): const SizedBox(),
        ],
      ),
    );
  }
}
