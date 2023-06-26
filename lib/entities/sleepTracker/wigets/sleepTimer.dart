import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SleepTimer extends StatefulWidget {
  const SleepTimer({Key? key}) : super(key: key);

  @override
  State<SleepTimer> createState() => _SleepTimerState();
}

class _SleepTimerState extends State<SleepTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 125,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(ProjectColors.blackBackground),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Expanded(
                      flex: 60,
                      child: Container(
                        width: 80,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(15)),
                          color: Color(ProjectColors.blue),
                        ),
                        child: const Icon(FontAwesomeIcons.solidMoon,
                            color: Colors.white, size: 36),
                      )),
                  Expanded(
                      flex: 35,
                      child: Container(
                        width: 80,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15)),
                          color: Color(ProjectColors.gray),
                        ),
                        child: const Center(
                          child: Text("Go to sleep",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              softWrap: true),
                        ),
                      ))
                ],
              ),
            ),
            Column(
              children:  const [
                Text(
                  "Time to sleep",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.sourceSansPro),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(ProjectColors.strongBlue)),
                    value: 0.8,
                    color: Colors.white,
                    backgroundColor: Colors.white,
                    strokeWidth: 8,

                  ),
                )
              ],
            ),
            Column(
              children:  [
                Switch(value: true, onChanged: (value){})
              ],
            )
          ],
        ));
  }
}
