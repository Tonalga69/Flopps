
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';

import '../../../utils/Strings.dart';

class FriendsListWidget extends StatelessWidget {
  const FriendsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
              color: const Color(ProjectColors.white),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(5, 5),
                  spreadRadius: 1,
                  blurRadius: 1
                )
              ]

            ),
            child: Column(
              children:  [
                const Text(Strings.friends, style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.sourceSansPro,
                  fontSize: 14
                ),),
                SizedBox(
                  height: 100,
                  child: ListView(),
                )
              ],
            ),
          ),
          Positioned(child: Container())
        ],
      ));
  }
}
