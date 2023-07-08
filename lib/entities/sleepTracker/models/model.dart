import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class SleepTracker {
  late final String uid;
  late Double? averageSleepingHours;
  late Double? averageSnoring;
  late Map<Int, Double>? awakeHours;
  late Map<Int, Double>? sleepingHours;
  late Map<Int, Double>? snoringTimes;
  late Map<Int, Double>? snoringLastWeek;
  late Timestamp? timeToSleep;
  late Timestamp? timeToWakeUp;

  SleepTracker(
      {required this.uid,
      this.averageSleepingHours,
      this.averageSnoring,
      this.awakeHours,
      this.sleepingHours,
      this.snoringTimes,
      this.snoringLastWeek,
      this.timeToSleep,
      this.timeToWakeUp});

  factory SleepTracker.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return SleepTracker(
        uid: data?["uid"],
        averageSleepingHours: data?["averageSleepingHours"],
        averageSnoring: data?["averageSnoring"],
        awakeHours: data?["awakeHours"],
        sleepingHours: data?["sleepingHours"],
        snoringLastWeek: data?["snoringLastWeek"],
        snoringTimes: data?["snoringTimes"],
        timeToSleep: data?["timeToSleep"],
        timeToWakeUp: data?["timeToWakeUp"]);
  }

  toJson(){
    return {
      "uid": uid,
      "averageSleepingHours": averageSleepingHours,
      "averageSnoring": averageSnoring,
      "awakeHours": awakeHours,
      "sleepingHours": sleepingHours,
      "snoringLastWeek": snoringLastWeek,
      "snoringTimes": snoringTimes,
      "timeToSleep": timeToSleep,
      "timeToWakeUp": timeToWakeUp
    };
  }
}
