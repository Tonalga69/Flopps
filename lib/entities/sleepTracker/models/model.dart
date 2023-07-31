import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

enum StatusType { awake, sleeping, none }

final _stringToStatus = {
  "awake": StatusType.awake,
  "sleeping": StatusType.sleeping,
  "none": StatusType.none
};

class SleepTracker {
  late final String? uid;
  late Double? averageSleepingHours;
  late Double? averageSnoring;
  late Map<Int, Double>? awakeHours;
  late Map<Int, Double>? sleepingHours;
  late Map<Int, Double>? snoringTimes;
  late Map<Int, Double>? snoringLastWeek;
  Timestamp? timeToSleep = Timestamp.fromDate(DateTime.now());
  Timestamp? timeToWakeUp = Timestamp.fromDate(DateTime.now());
  Timestamp? timeWokenUp = Timestamp.fromDate(DateTime.now());
  Timestamp? timeSlept = Timestamp.fromDate(DateTime.now());
  late StatusType? status;

  SleepTracker(
      {this.uid,
      this.averageSleepingHours,
      this.averageSnoring,
      this.awakeHours,
      this.sleepingHours,
      this.snoringTimes,
      this.snoringLastWeek,
      this.timeToSleep,
      this.timeToWakeUp,
      this.status,
      this.timeWokenUp,
      this.timeSlept});

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
      timeToWakeUp: data?["timeToWakeUp"],
      status: getStatus(data?["status"]),
      timeWokenUp: data?["timeWokenUp"],
      timeSlept: data?["timeSlept"],
    );
  }

  static StatusType getStatus(String? status) {
    return _stringToStatus[status] ?? StatusType.none;
  }

  String _setStatus() {
    return _stringToStatus.keys.firstWhere(
        (key) => _stringToStatus[key] == status,
        orElse: () => "none");
  }

  toJson() {
    return {
      "uid": uid,
      "averageSleepingHours": averageSleepingHours,
      "averageSnoring": averageSnoring,
      "awakeHours": awakeHours,
      "sleepingHours": sleepingHours,
      "snoringLastWeek": snoringLastWeek,
      "snoringTimes": snoringTimes,
      "timeToSleep": timeToSleep,
      "timeToWakeUp": timeToWakeUp,
      "status": _setStatus(),
      "timeWokenUp": timeWokenUp,
      "timeSlept": timeSlept
    };
  }
}
