import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flopps/entities/sleepTracker/models/model.dart';
import 'package:flopps/entities/sleepTracker/repositories/firebase.dart';
import 'package:flopps/entities/sleepTracker/repositories/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackerController extends GetxController {
  static TrackerController get instance => Get.find();
  bool isSleeping = false;
  bool timerIsActive = false;

  SleepTracker tracker = SleepTracker();

  @override
  onReady() {
    getTracker().then((value) => null);
    getIsSleeping();
    getTimerIsActive();
  }

  void getIsSleeping() async {
    isSleeping =
        await SleepTrackerLocalStorageRepository.instance.checkIsSleeping();
    update();
  }

  void setIsSleeping(bool value) async {
    isSleeping = value;
    SleepTrackerLocalStorageRepository.instance.setIsSleeping(value);
    if (isSleeping) {
      tracker.timeToWakeUp = Timestamp.fromDate(DateTime.now());
    } else {
      tracker.timeToSleep = Timestamp.fromDate(DateTime.now());
    }
    update();
  }

  void getTimerIsActive() async {
    timerIsActive =
        await SleepTrackerLocalStorageRepository.instance.checkTimerIsActive();
    update();
  }

  void setTimerIsActive(bool value) async {
    timerIsActive = value;
    SleepTrackerLocalStorageRepository.instance.setTimerIsActive(value);
    update();
  }

  void getTimeWokenUp() async {
    tracker.timeWokenUp =
        await SleepTrackerLocalStorageRepository.instance.getTimeWokenUp();
    update();
  }

  void setTimeWokenUp(Timestamp time) async {
    tracker.timeWokenUp = time;
    await SleepTrackerLocalStorageRepository.instance.setTimeWokenUp(time);
  }

  void getTimeSlept() async {
    tracker.timeSlept =
        await SleepTrackerLocalStorageRepository.instance.getTimeSlept();
    update();
  }

  void setTimeSlept(Timestamp time) async {
    tracker.timeSlept = time;
    await SleepTrackerLocalStorageRepository.instance.setTimeSlept(time);
  }

  Future<void> getTracker() async {
    final result = await SleepTrackerFirebaseRepository.instance.getData();
    if (result != null) {
      tracker = SleepTracker.fromFirebase(result);
    }
  }

  void updateTimeTo(BuildContext context) async {
    final TimeOfDay? timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timePicked != null) {
      isSleeping
          ? tracker.timeToSleep = Timestamp.fromDate(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              timePicked.hour,
              timePicked.minute))
          : tracker.timeToWakeUp = Timestamp.fromDate(DateTime(
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
