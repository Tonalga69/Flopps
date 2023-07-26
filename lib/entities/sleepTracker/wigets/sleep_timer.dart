import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:switcher_button/switcher_button.dart';

import '../controllers/tracker_controller.dart';

class SleepTimer extends StatefulWidget {
  const SleepTimer({Key? key}) : super(key: key);

  @override
  State<SleepTimer> createState() => _SleepTimerState();
}

class _SleepTimerState extends State<SleepTimer> {
  final _trackerController = TrackerController.instance;

  @override
  Widget build(BuildContext context) {
    _trackerController.getTimerIsActive();
    return Container(
        height: 135,
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
              onTap: () {
                _trackerController
                    .setIsSleeping(!_trackerController.isSleeping);
              },
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
                        child: GetBuilder<TrackerController>(
                          builder: (controller) => controller.isSleeping
                              ? const Icon(
                                  FontAwesomeIcons.sun,
                                  color: Colors.white,
                                  size: 36,
                                )
                              : const Icon(FontAwesomeIcons.solidMoon,
                                  color: Colors.white, size: 36),
                        ),
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
                        child: GetBuilder<TrackerController>(
                          builder: (controller) => controller.isSleeping
                              ? const Center(
                                  child: Text("Wake up",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      softWrap: true),
                                )
                              : const Center(
                                  child: Text("Go to sleep",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      softWrap: true),
                                ),
                        ),
                      ))
                ],
              ),
            ),
            Column(
              children: [
                GetBuilder<TrackerController>(
                  builder: (controller) => Text(
                    controller.isSleeping
                        ? Strings.timeToWake
                        : Strings.timeToSleep,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.sourceSansPro),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: GetBuilder<TrackerController>(
                      builder: (controller) => CircularPercentIndicator(
                        radius: 25,
                        backgroundColor: Colors.white,
                        center: Text(
                            "${(getPercentage(controller.isSleeping) * 100).toStringAsFixed(0)}%",
                            style: const TextStyle(color: Colors.white)),
                        animateFromLastPercent: true,
                        curve: Curves.linear,
                        percent: getPercentage(controller.isSleeping),
                        animationDuration: 2,
                        animation: true,
                        progressColor: const Color(ProjectColors.blue),
                      ),
                    )),
                GetBuilder<TrackerController>(
                  builder: (controller) => Text(
                    softWrap: true,
                    controller.isSleeping
                        ? remainingTime(
                            controller.tracker.timeToSleep?.toDate().hour ?? 0)
                        : remainingTime(
                            controller.tracker.timeToWakeUp?.toDate().hour ??
                                0),
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<TrackerController>(
                    builder: (controller)=> SwitcherButton(
                      value: controller.timerIsActive,
                      offColor: const Color(ProjectColors.white),
                      size: 40,
                      onColor: const Color(ProjectColors.blue),
                      onChange: (value) {
                        setState(() {
                          _trackerController.setTimerIsActive(value);
                        });
                      },
                    ),
                  ),
                ),
                GetBuilder<TrackerController>(
                  init: TrackerController(),
                  builder: (controller) => controller.isSleeping
                      ? Text(

                          "${controller.tracker.timeToSleep?.toDate().hour.toString()}:${(controller.tracker.timeToSleep?.toDate().minute).toString().padLeft(2, "0")}",
                          style: const TextStyle(
                              color: Color(ProjectColors.white)),
                    softWrap: true,
                        )
                      : Text(
                          "${controller.tracker.timeToWakeUp?.toDate().hour.toString()}:${(controller.tracker.timeToWakeUp?.toDate().minute).toString().padLeft(2, "0")}",
                          style: const TextStyle(
                              color: Color(ProjectColors.white)),
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    _trackerController.updateTimeTo(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        Strings.edit,
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

  String remainingTime(int targetHour) {
    final currentTime = DateTime.now();
    DateTime targetTime = currentTime.isBefore(DateTime(
            currentTime.year, currentTime.month, currentTime.day, targetHour))
        ? DateTime(
            currentTime.year, currentTime.month, currentTime.day, targetHour)
        : DateTime(currentTime.year, currentTime.month, currentTime.day,
                targetHour)
            .add(const Duration(days: 1));
    return targetTime.difference(currentTime).inHours < 1
        ? "${Strings.timeRemaining} ${targetTime.difference(currentTime).inMinutes} ${Strings.minutes}"
        : "${Strings.timeRemaining} ${targetTime.difference(currentTime).inHours} ${Strings.hours}";
  }

  double getPercentage(bool isSleeping) {
    final currentTime = DateTime.now();
    final targetTime = currentTime.isBefore(DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            !isSleeping
                ? _trackerController.tracker.timeToWakeUp?.toDate().hour ?? 0
                : _trackerController.tracker.timeToSleep?.toDate().hour ?? 0,
        !isSleeping
            ? _trackerController.tracker.timeToSleep?.toDate().minute ?? 0
            : _trackerController.tracker.timeToWakeUp?.toDate().minute ?? 0),
    )
        ? DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            !isSleeping
                ? _trackerController.tracker.timeToWakeUp?.toDate().hour ?? 0
                : _trackerController.tracker.timeToSleep?.toDate().hour ?? 0,
        !isSleeping
            ? _trackerController.tracker.timeToSleep?.toDate().minute ?? 0
            : _trackerController.tracker.timeToWakeUp?.toDate().minute ?? 0)
        : DateTime(
                currentTime.year,
                currentTime.month,
                currentTime.day,
                !isSleeping
                    ? _trackerController.tracker.timeToWakeUp?.toDate().hour ??
                        0
                    : _trackerController.tracker.timeToSleep?.toDate().hour ??
                        0,
        !isSleeping
            ? _trackerController.tracker.timeToSleep?.toDate().minute ?? 0
            : _trackerController.tracker.timeToWakeUp?.toDate().minute ?? 0)
            .add(const Duration(days: 1));
    final initialTime = currentTime.isAfter(DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            !isSleeping
                ? _trackerController.tracker.timeToSleep?.toDate().hour ?? 0
                : _trackerController.tracker.timeToWakeUp?.toDate().hour ?? 0,
        !isSleeping
            ? _trackerController.tracker.timeToSleep?.toDate().minute ?? 0
            : _trackerController.tracker.timeToWakeUp?.toDate().minute ?? 0))
        ? DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            !isSleeping
                ? _trackerController.tracker.timeToSleep?.toDate().hour ?? 0
                : _trackerController.tracker.timeToWakeUp?.toDate().hour ?? 0,
        !isSleeping
            ? _trackerController.tracker.timeToSleep?.toDate().minute ?? 0
            : _trackerController.tracker.timeToWakeUp?.toDate().minute ?? 0)
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            !isSleeping
                ? _trackerController.tracker.timeToSleep?.toDate().hour ?? 0
                : _trackerController.tracker.timeToWakeUp?.toDate().hour ?? 0,
        !isSleeping
            ? _trackerController.tracker.timeToSleep?.toDate().minute ?? 0
            : _trackerController.tracker.timeToWakeUp?.toDate().minute ?? 0);

    final aux= double.parse(((targetTime.difference(initialTime).inMinutes -
                targetTime.difference(currentTime).inMinutes) /
            targetTime.difference(initialTime).inMinutes)
        .toStringAsFixed(2));

    if(aux>1 || aux<0){
      return 1;
    }
    
    return aux;

  }
}
