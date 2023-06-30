import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:switcher_button/switcher_button.dart';

class SleepTimer extends StatefulWidget {
  const SleepTimer({Key? key}) : super(key: key);

  @override
  State<SleepTimer> createState() => _SleepTimerState();
}

class _SleepTimerState extends State<SleepTimer> {
  bool activeTimer = true;

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
                  spreadRadius: 2,
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
              children: [
                const Text(
                  "Time to sleep",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.sourceSansPro),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircularPercentIndicator(
                      radius: 25,
                      backgroundColor: Colors.white,
                      center: const Text("80%",
                          style: TextStyle(color: Colors.white)),
                      animateFromLastPercent: true,
                      curve: Curves.linear,
                      percent: .80,
                      animationDuration: 2,
                      animation: true,
                      progressColor: const Color(ProjectColors.blue),
                    )),
                const Text(
                  "2 hours remaining",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitcherButton(
                    value: activeTimer,
                    offColor: const Color(ProjectColors.white),
                    size: 40,
                    onColor: const Color(ProjectColors.blue),
                    onChange: (value) {
                      setState(() {
                        activeTimer = value;
                      });
                    },
                  ),
                ),
                const Text(
                  "11:30PM",
                  style: TextStyle(color: Color(ProjectColors.white)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Edit",
                        style: TextStyle(color: Color(ProjectColors.white)),
                      ),
                      Transform.rotate(
                        angle: 135,
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
