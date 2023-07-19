import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';
import 'package:localstore/localstore.dart' as localstore;

class SleepTrackerLocalStorageRepository extends GetxController {
  static SleepTrackerLocalStorageRepository get instance => Get.find();
  final _localDB = localstore.Localstore.instance;
  final _auth = FirebaseAuth.instance;

  Future<bool> checkIsSleeping() async {
    final data = await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .get();
    if (data!["isSleeping"] != null) {
      return data["isSleeping"];
    }
    return false;
  }

  Future<void> setIsSleeping(bool value) async {
    await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .set({"isSleeping": value}, localstore.SetOptions(merge: true));
  }

  Future<bool> checkTimerIsActive() async {
    final data = await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .get();
    if (data!["timerIsActive"] != null) {
      return data["timerIsActive"];
    }
    return false;
  }

  Future<void> setTimerIsActive(bool value) async {
    await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .set({"timerIsActive": value}, localstore.SetOptions(merge: true));
  }

  Future<Timestamp> getTimeWokenUp() async {
    final data = await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .get();

    if (data!["timeWokenUp"] != null) {
      return Timestamp.fromDate(
          DateTime.fromMillisecondsSinceEpoch(data["timeWokenUp"]));
    }
    return Timestamp.fromDate(DateTime.now());
  }

  Future<void> setTimeWokenUp(Timestamp value) async {
    await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .set({"timeWokenUp": value.toDate().millisecondsSinceEpoch},
            localstore.SetOptions(merge: true));
  }

  Future<Timestamp> getTimeSlept() async {
    final data = await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .get();
    if (data!["timeSlept"] != null) {
      return Timestamp.fromDate(
          DateTime.fromMillisecondsSinceEpoch(data["timeSlept"]));
    }
    return Timestamp.fromDate(DateTime.now());
  }

  Future<void> setTimeSlept(Timestamp value) async {
    await _localDB
        .collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .set({"timeSlept": value.toDate().millisecondsSinceEpoch});
  }
}
