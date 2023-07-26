import 'package:flopps/entities/users/widgets/friends_list_item.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../utils/Strings.dart';

class FriendsListWidget extends StatefulWidget {
  const FriendsListWidget({super.key});

  @override
  State<FriendsListWidget> createState() => _FriendsListWidgetState();
}

class _FriendsListWidgetState extends State<FriendsListWidget> {
  final _scrollController = AutoScrollController();
  late int scrollPosition = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToIndex() async {
    await _scrollController.scrollToIndex(scrollPosition + 3,
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(ProjectColors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(5, 5),
                        spreadRadius: 1,
                        blurRadius: 1)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      Strings.topFriends,
                      style: TextStyle(
                          color: Color(ProjectColors.darkBackground),
                          fontFamily: FontFamily.sourceSansPro,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.only(right: 60),
                    child: NotificationListener<ScrollEndNotification>(
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 50,
                        itemBuilder: (context, index) => AutoScrollTag(
                            controller: _scrollController,
                            key: ValueKey(index),
                            index: index,
                            child: const FriendsListItem()),
                      ),
                      onNotification: (notification) {
                        setState(() {
                          scrollPosition =
                              (notification.metrics.pixels / 90).round();
                        });
                        return true;
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: _scrollToIndex,
                child: Container(
                  width: 60,
                  decoration: const BoxDecoration(
                      color: Color(ProjectColors.blue),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
                  child: const Icon(Icons.send, size: 36, color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
