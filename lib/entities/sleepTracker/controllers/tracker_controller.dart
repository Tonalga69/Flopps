import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flopps/entities/sleepTracker/models/model.dart';
import 'package:flopps/entities/sleepTracker/repositories/firebase.dart';
import 'package:flopps/entities/sleepTracker/repositories/local_storage.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Strings.dart';

class TrackerController extends GetxController {
  static TrackerController get instance => Get.find();
  bool isSleeping = true;
  bool timerIsActive = false;

  SleepTracker tracker = SleepTracker();

  @override
  onReady() {
    getTracker().then((value) => null);
    getIsSleeping();
    getTimerIsActive();
  }

  Future<bool> getIsSleeping() async {
    isSleeping =
        await SleepTrackerLocalStorageRepository.instance.checkIsSleeping();
    update();

    return isSleeping;
  }

  void setIsSleeping(bool value) async {
    isSleeping = value;
    SleepTrackerLocalStorageRepository.instance.setIsSleeping(value);
    if (isSleeping) {
      tracker.timeWokenUp = Timestamp.fromDate(DateTime.now());
      setTimeWokenUp(tracker.timeWokenUp!);
    } else {
      tracker.timeSlept = Timestamp.fromDate(DateTime.now());
      setTimeSlept(tracker.timeSlept!);
    }
    update();
  }

  Future<bool> getTimerIsActive() async {
    timerIsActive =
        await SleepTrackerLocalStorageRepository.instance.checkTimerIsActive();
    update();
    return timerIsActive;
  }

  void setTimerIsActive(bool value) async {
    timerIsActive = value;
    SleepTrackerLocalStorageRepository.instance.setTimerIsActive(value);
    if (value) {
      Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 5),
          isDismissible: true,
          titleText: Text(
            Strings.sleepTracker,
            style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(ProjectColors.white),
                fontFamily: FontFamily.sourceSansPro),
          ),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Color(ProjectColors.blackBackground),
          messageText: Text(
            Strings.youWillBeNotified,
            style: TextStyle(
                color: Color(ProjectColors.white),
                fontFamily: FontFamily.sourceSansPro),
          )));
    }
    update();
  }

  Future<void> getTimeWokenUp() async {
    tracker.timeWokenUp =
        await SleepTrackerLocalStorageRepository.instance.getTimeWokenUp();
    update();
  }

  Future<void> setTimeWokenUp(Timestamp time) async {
    tracker.timeWokenUp = time;
    await SleepTrackerLocalStorageRepository.instance.setTimeWokenUp(time);
  }

  Future<void> getTimeSlept() async {
    tracker.timeSlept =
        await SleepTrackerLocalStorageRepository.instance.getTimeSlept();
    update();
  }

  Future<void> setTimeSlept(Timestamp time) async {
    tracker.timeSlept = time;
    await SleepTrackerLocalStorageRepository.instance.setTimeSlept(time);
  }

  Future<void> getTracker() async {
    final result = await SleepTrackerFirebaseRepository.instance.getData();
    if (result != null) {
      tracker = SleepTracker.fromFirebase(result);
    }
    await getTimeWokenUp();
    await getTimeSlept();
    update();
  }

  void updateTimeTo(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return TimePickerDialog(
          initialTime: TimeOfDay.now(),
        );
      },
    );

    if (timePicked != null) {
      isSleeping
          ? tracker.timeToWakeUp = Timestamp.fromDate(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              timePicked.hour,
              timePicked.minute))
          : tracker.timeToSleep = Timestamp.fromDate(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              timePicked.hour,
              timePicked.minute));

      final data = await SleepTrackerFirebaseRepository.instance
          .updateTracker(tracker.toJson());
      if (data != null) {
        tracker = SleepTracker.fromFirebase(data);
      }
    }
    update();
  }

  void updateTracker(SleepTracker sleepTracker) async {
    final updatedDoc = await SleepTrackerFirebaseRepository.instance
        .updateTracker(sleepTracker.toJson());
    if (updatedDoc != null) {
      tracker = sleepTracker;
    }

    update();
  }
}
